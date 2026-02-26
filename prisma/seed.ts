import { Pool } from 'pg';
import { PrismaPg } from '@prisma/adapter-pg';
import { PrismaClient } from '@prisma/client';
import "dotenv/config";

const connectionString = process.env.DATABASE_URL;
const pool = new Pool({ connectionString });
const adapter = new PrismaPg(pool);
const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('Starting seed script...');
  
  const company = await prisma.firma.create({
    data: {
      name: 'Nexoro Demo GmbH',
      email: 'hello@nexoro.demo',
      strasse: 'Musterstraße 12',
      ort: 'Musterstadt',
      aktiv: 1,
    }
  });
  console.log(`Created company: ${company.name}`);

  const user = await prisma.users.create({
    data: {
      username: 'agent_demo',
      nameKurz: 'ADM',
      aktiv: 1,
      password: 'demo'
    }
  });
  console.log(`Created user: ${user.username}`);

  const order = await prisma.orders.create({
    data: {
      auftragsnummer: BigInt(1000001), // BigInt constructor instead of 'n' literal
      firma: company.name,
      createdAt: new Date(),
      user: user.username,
      aktiv: 1,
      serviceArt: 'Webdesign'
    }
  });
  console.log(`Created order (project): ${order.auftragsnummer.toString()}`);
  
  const offer = await prisma.angebot.create({
    data: {
      bezeichnung: 'Angebot für Website Layout',
      nettoPreis: '4500.00',
      bruttoPreis: '5355.00',
      bearbeiter: user.username
    }
  });
  console.log(`Created offer: ${offer.bezeichnung}`);

  console.log('Seed completed successfully!');
}

main()
  .catch((e) => {
    console.error('Seed failed:', e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
