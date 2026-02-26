import re
import os

sql_file = '/Users/wolfgangpreinfalk/Documents/GitHub/oms-cluster/init.sql'
out_file = '/Users/wolfgangpreinfalk/Documents/GitHub/nexoro/prisma/schema.prisma'

with open(sql_file, 'r', encoding='utf-8') as f:
    lines = f.readlines()

type_map = {
    'int': 'Int', 'tinyint': 'Int', 'smallint': 'Int', 'mediumint': 'Int', 'bigint': 'BigInt',
    'float': 'Float', 'double': 'Float', 'decimal': 'Decimal', 'numeric': 'Decimal',
    'varchar': 'String', 'char': 'String', 'text': 'String', 'mediumtext': 'String', 'longtext': 'String', 'enum': 'String',
    'date': 'DateTime', 'datetime': 'DateTime', 'timestamp': 'DateTime', 'time': 'DateTime',
    'boolean': 'Boolean'
}

def map_type(mysql_type):
    mysql_type = mysql_type.lower()
    if 'tinyint(1)' in mysql_type: return 'Boolean'
    for k, v in type_map.items():
        if mysql_type.startswith(k):
            return v
    return 'String'

def to_camel(name):
    clean_name = re.sub(r'[^a-zA-Z0-9]+', '_', name)
    camel = re.sub(r'_([a-zA-Z0-9])', lambda m: m.group(1).upper(), clean_name)
    if camel and camel[0].isdigit():
        camel = 'n' + camel
    return camel


models = []
current_table = None
current_fields = []
primary_keys = []

for line in lines:
    line = line.strip()
    if line.startswith('CREATE TABLE'):
        match = re.search(r'CREATE TABLE( IF NOT EXISTS)? `([^`]+)`', line)
        if match:
            current_table = match.group(2)
            current_fields = []
            primary_keys = []
    elif current_table and line.startswith(') ENGINE'):
        model_name = ''.join(word.capitalize() for word in current_table.split('_'))
        models.append({
            'table': current_table,
            'model': model_name,
            'fields': current_fields,
            'pks': primary_keys
        })
        current_table = None
    elif current_table:
        pk_match = re.search(r'PRIMARY KEY \(`([^`]+)`\)', line)
        if pk_match:
            primary_keys.append(pk_match.group(1))
            continue
            
        pk_multi = re.search(r'PRIMARY KEY \(([^)]+)\)', line)
        if pk_multi and not pk_match:
            keys = [k.strip('` ') for k in pk_multi.group(1).split(',')]
            primary_keys.extend(keys)
            continue
            
        col_match = re.match(r'`([^`]+)`\s+([a-zA-Z0-9_]+(?:\([^)]+\))?)\s*(.*?),?$', line)
        if col_match:
            col_name, col_type, rest = col_match.groups()
            p_type = map_type(col_type)
            is_optional = "NOT NULL" not in rest and "PRIMARY KEY" not in rest
            if is_optional: p_type += "?"
            
            attrs = []
            if "AUTO_INCREMENT" in rest: attrs.append("@default(autoincrement())")
            
            def_match = re.search(r"DEFAULT\s+('([^']*)'|([A-Za-z0-9_.-]+))", rest, re.IGNORECASE)
            if def_match and 'autoincrement()' not in attrs:
                val = def_match.group(2) if def_match.group(2) is not None else def_match.group(3)
                if val.upper() != 'NULL':
                    if p_type.startswith('Int') or p_type.startswith('Float') or p_type.startswith('Decimal'):
                        if val.replace('-','').replace('.','').isdigit(): attrs.append(f"@default({val})")
                    elif p_type.startswith('Boolean'):
                        attrs.append(f"@default({'true' if val=='1' else 'false'})")
                    elif p_type.startswith('String') and "CURRENT_TIMESTAMP" not in val.upper():
                        attrs.append(f'@default("{val}")')
                    elif p_type.startswith('DateTime') and "CURRENT_TIMESTAMP" in val.upper():
                        attrs.append(f'@default(now())')
            
            camel = to_camel(col_name)
            if camel != col_name: attrs.append(f'@map("{col_name}")')
            
            current_fields.append({'orig': col_name, 'camel': camel, 'type': p_type, 'attrs': attrs})


out = []
out.append('generator client {\n  provider = "prisma-client-js"\n}\n')
out.append('datasource db {\n  provider = "postgresql"\n}\n')

for m in models:
    lines = [f'model {m["model"]} {{']
    pks = m['pks']
    for f in m['fields']:
        attr_str = " ".join(f['attrs'])
        if len(pks) == 1 and f['orig'] == pks[0]:
            if "@id" not in attr_str: attr_str += " @id"
        lines.append(f'  {f["camel"]} {f["type"]} {attr_str}')
    if len(pks) > 1:
        pk_camels = [to_camel(orig) for orig in pks]
        if pk_camels: lines.append(f'  @@id([{", ".join(pk_camels)}])')
    if not pks:
        lines.append('  @@ignore // No primary key found')
        
    if m['table'] != m['model']:
        lines.append(f'  @@map("{m["table"]}")')
    lines.append('}\n')
    out.append("\n".join(lines))

with open(out_file, 'w') as f:
    f.write("\n".join(out))

print(f"Generated {len(models)} models.")
