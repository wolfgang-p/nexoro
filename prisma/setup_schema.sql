-- CreateSchema
CREATE SCHEMA IF NOT EXISTS "public";

-- CreateTable
CREATE TABLE "abgabestellen" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER DEFAULT 0,
    "abholung" TEXT,
    "art" TEXT DEFAULT 'Annahmestelle (Partner)',
    "ansprechperson" TEXT,
    "strasse" TEXT,
    "plz" TEXT,
    "ort" TEXT,
    "land" TEXT DEFAULT 'Österreich',
    "von" TEXT DEFAULT '08:00',
    "bis" TEXT DEFAULT '18:00',
    "telefonnummer" TEXT,
    "email" TEXT,
    "abgabe_firma" TEXT,
    "oeffnungszeit" TEXT,
    "wegbeschreibung" TEXT,
    "zusatz_id" TEXT,
    "not_in_id" TEXT,
    "partnerstufe" TEXT,
    "standort_art" TEXT,
    "tel_anz_standort" TEXT,
    "mail_anz_standort" TEXT,
    "created_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3),
    "user_last_save" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "lat" TEXT,
    "lng" TEXT,
    "footer_text_indiv" TEXT,
    "regionalcode" TEXT,

    CONSTRAINT "abgabestellen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "abgabestellen_1" (
    "id" SERIAL NOT NULL,
    "abholung" TEXT,
    "art" TEXT DEFAULT 'Annahmestelle (Partner)',
    "von" TEXT DEFAULT '08:00',
    "bis" TEXT DEFAULT '18:00',
    "oeffnungszeit" TEXT,
    "wegbeschreibung" TEXT,
    "standort_art" TEXT,
    "tel_anz_standort" TEXT,
    "mail_anz_standort" TEXT,
    "created_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3),
    "user_last_save" TEXT,
    "aktiv" INTEGER DEFAULT 0,
    "lat" TEXT,
    "lng" TEXT,
    "footer_text_indiv" TEXT,
    "regionalcode" TEXT,
    "mybusiness_eintrag" TIMESTAMP(3),
    "mybusiness_verifiziert" TIMESTAMP(3),
    "anmerkungen_oeffnungszeit" TEXT,
    "bundesland" TEXT,
    "name" TEXT,
    "google_places_id" TEXT,
    "google_review_rating" TEXT,
    "mybusiness_status" TEXT,

    CONSTRAINT "abgabestellen_1_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "abholungen_abgabestelle" (
    "id" SERIAL NOT NULL,
    "datum" TIMESTAMP(3),
    "user" TEXT,
    "abgabestelle_id" INTEGER,

    CONSTRAINT "abholungen_abgabestelle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "abholungsarten" (
    "id" SERIAL NOT NULL,
    "art" TEXT NOT NULL,
    "product_name_inland" TEXT,
    "product_name_europa" TEXT,
    "product_name_ausland" TEXT,

    CONSTRAINT "abholungsarten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "abholungsarten_land" (
    "id" SERIAL NOT NULL,
    "abholungsart_id" INTEGER NOT NULL,
    "globalProductCode" TEXT,
    "localProductCode" TEXT,
    "land" TEXT,
    "bezeichnung" TEXT,

    CONSTRAINT "abholungsarten_land_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "abteilungen_contacts" (
    "id" SERIAL NOT NULL,
    "name" TEXT,

    CONSTRAINT "abteilungen_contacts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "action_log" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "date" TIMESTAMP(3),
    "typ" TEXT,
    "order_id" TEXT,

    CONSTRAINT "action_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_accounts" (
    "id" SERIAL NOT NULL,
    "customer_id" TEXT NOT NULL DEFAULT '',
    "name" TEXT NOT NULL DEFAULT '',
    "aktiv" INTEGER DEFAULT 1,
    "waehrung" TEXT,
    "hauptaccount" INTEGER DEFAULT 0,
    "kuerzel" TEXT,

    CONSTRAINT "adwords_accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_adgroup" (
    "id" SERIAL NOT NULL,
    "adgroup_id" TEXT NOT NULL DEFAULT '',
    "adgroup_name" TEXT NOT NULL DEFAULT '',
    "createDate" TIMESTAMP(3),
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "updateDate" TIMESTAMP(3),
    "aktiv" INTEGER DEFAULT 1,
    "typ" TEXT NOT NULL,

    CONSTRAINT "adwords_adgroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_campaign" (
    "id" SERIAL NOT NULL,
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "campaign_name" TEXT NOT NULL DEFAULT '',
    "website_id" INTEGER NOT NULL,
    "aktiv" INTEGER DEFAULT 0,
    "customer_id" TEXT NOT NULL DEFAULT '',
    "kuerzel_land" TEXT NOT NULL DEFAULT '',
    "campaign_tracking" INTEGER DEFAULT 0,
    "Status" TEXT NOT NULL DEFAULT '',
    "updateDate" TIMESTAMP(3),
    "insertdate" TIMESTAMP(3),

    CONSTRAINT "adwords_campaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_campaign_location" (
    "id" SERIAL NOT NULL,
    "CampaignId" TEXT,
    "CriterionId" TEXT,
    "LocationName" TEXT,
    "TargetingStatus" TEXT,
    "CampaignStatus" TEXT,
    "createDate" TIMESTAMP(3),
    "CustomerId" TEXT,
    "updateDate" TIMESTAMP(3),
    "active" INTEGER DEFAULT 0,
    "country" TEXT,
    "TargetType" TEXT,
    "name_normal" TEXT,
    "adwords_mapdata_city_id" INTEGER,
    "type" TEXT,
    "radius" DOUBLE PRECISION,
    "radiusDistanceUnits" TEXT,
    "latlng" TEXT,

    CONSTRAINT "adwords_campaign_location_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_campaign_performance" (
    "id" SERIAL NOT NULL,

    CONSTRAINT "adwords_campaign_performance_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_campaign_stats" (
    "id" SERIAL NOT NULL,
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "campaign_name" TEXT NOT NULL DEFAULT '',
    "website_id" INTEGER NOT NULL,
    "clicks" INTEGER,
    "cost" DOUBLE PRECISION,
    "datum" TIMESTAMP(3),
    "website_name" TEXT NOT NULL DEFAULT '',
    "insertdate" TIMESTAMP(3),
    "coversion_value" DOUBLE PRECISION,
    "converted_clicks" DOUBLE PRECISION,
    "average_position" DOUBLE PRECISION,
    "cost_per_conv_adwords" DOUBLE PRECISION,
    "impressions" DOUBLE PRECISION,
    "clicktype" TEXT DEFAULT '',
    "ad_group_id" TEXT NOT NULL DEFAULT '',
    "criteriatype" TEXT NOT NULL DEFAULT '',
    "slot" TEXT DEFAULT '',
    "companyname" TEXT NOT NULL DEFAULT '',
    "keyword_id" TEXT NOT NULL DEFAULT '',
    "average_cpc" DOUBLE PRECISION,
    "views" INTEGER,
    "average_cpv" DOUBLE PRECISION,
    "absolute_top_impression_percentage" DOUBLE PRECISION,
    "search_absolute_top_impression_share" DOUBLE PRECISION,
    "search_budget_lost_absolute_top_impression_share" DOUBLE PRECISION,
    "search_rank_lost_absolute_top_impression_share" DOUBLE PRECISION,
    "top_impression_percentage" DOUBLE PRECISION,
    "search_top_impression_share" DOUBLE PRECISION,
    "search_budget_lost_top_impression_share" DOUBLE PRECISION,
    "search_rank_lost_top_impression_share" DOUBLE PRECISION,

    CONSTRAINT "adwords_campaign_stats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_campaign_stats_hour" (
    "id" SERIAL NOT NULL,
    "main_id" TEXT NOT NULL DEFAULT '',
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "campaign_name" TEXT NOT NULL DEFAULT '',
    "website_id" INTEGER NOT NULL,
    "clicks" INTEGER,
    "cost" DOUBLE PRECISION,
    "datum" TIMESTAMP(3),
    "hour" INTEGER,
    "website_name" TEXT NOT NULL DEFAULT '',
    "insertdate" TIMESTAMP(3),
    "coversion_value" DOUBLE PRECISION,
    "converted_clicks" DOUBLE PRECISION,
    "average_position" DOUBLE PRECISION,
    "cost_per_conv_adwords" DOUBLE PRECISION,
    "impressions" DOUBLE PRECISION,
    "clicktype" TEXT NOT NULL DEFAULT '',
    "ad_group_id" TEXT NOT NULL DEFAULT '',
    "criteriatype" TEXT NOT NULL DEFAULT '',
    "slot" TEXT NOT NULL DEFAULT '',
    "companyname" TEXT NOT NULL DEFAULT '',

    CONSTRAINT "adwords_campaign_stats_hour_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_click_report" (
    "id" SERIAL NOT NULL,
    "gclid" TEXT NOT NULL DEFAULT '',
    "keyword" TEXT NOT NULL DEFAULT '',
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "click_typ" TEXT,
    "region" TEXT,
    "datum" TIMESTAMP(3),
    "insertdate" TIMESTAMP(3),
    "ad_type" TEXT,
    "ad_group_id" TEXT,
    "network" TEXT,
    "network_search" TEXT,
    "city" TEXT,
    "ad_id" TEXT,
    "device" TEXT,
    "top_other" TEXT,
    "keywordId" TEXT,

    CONSTRAINT "adwords_click_report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_geotargets" (
    "id" SERIAL NOT NULL,
    "criteriaid" TEXT,
    "name" TEXT,
    "canonicalname" TEXT,
    "parentid" TEXT,
    "countrycode" TEXT,
    "targetype" TEXT,
    "status" TEXT,
    "name_normal" TEXT,

    CONSTRAINT "adwords_geotargets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_keywords" (
    "id" SERIAL NOT NULL,
    "KeywordId" TEXT,
    "Keyword" TEXT,
    "money_keyword" INTEGER DEFAULT 0,
    "CpcBid" DOUBLE PRECISION,
    "AdGroupId" TEXT,
    "MatchType" TEXT,
    "UserStatus" TEXT,
    "createDate" TIMESTAMP(3),
    "updateDate" TIMESTAMP(3),
    "CampaignId" TEXT,
    "optimate" INTEGER DEFAULT 0,
    "posMin" DOUBLE PRECISION DEFAULT 0,
    "posMax" DOUBLE PRECISION DEFAULT 0,
    "percentUp" DOUBLE PRECISION DEFAULT 0,
    "percentDown" DOUBLE PRECISION DEFAULT 0,
    "CustomerId" TEXT,
    "dateRange" TEXT,
    "cpcMax" DOUBLE PRECISION DEFAULT 0,
    "updated_date" TIMESTAMP(3),
    "absolute_top_impression_percentage_from" DOUBLE PRECISION DEFAULT 0,
    "absolute_top_impression_percentage_to" DOUBLE PRECISION DEFAULT 0,
    "top_impression_percentage_from" DOUBLE PRECISION DEFAULT 0,
    "top_impression_percentage_to" DOUBLE PRECISION DEFAULT 0,

    CONSTRAINT "adwords_keywords_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_keywords_daterange" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "adwords_keywords_daterange_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_keywords_log" (
    "id" SERIAL NOT NULL,
    "CustomerId" TEXT,
    "KeywordId" TEXT,
    "CpcBid" DOUBLE PRECISION,
    "AdGroupId" TEXT,
    "UserStatus" TEXT,
    "createDate" TIMESTAMP(3),
    "CampaignId" TEXT,
    "Keyword" TEXT,
    "CpcBidOld" DOUBLE PRECISION,

    CONSTRAINT "adwords_keywords_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_keywords_optimize_type" (
    "id" SERIAL NOT NULL,
    "type" TEXT,

    CONSTRAINT "adwords_keywords_optimize_type_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_keywords_to_update" (
    "id" SERIAL NOT NULL,
    "CustomerId" TEXT,
    "KeywordId" TEXT,
    "CpcBid" DOUBLE PRECISION,
    "AdGroupId" TEXT,
    "UserStatus" TEXT,
    "createDate" TIMESTAMP(3),
    "CampaignId" TEXT,
    "Keyword" TEXT,
    "CpcBidOld" DOUBLE PRECISION DEFAULT 0,

    CONSTRAINT "adwords_keywords_to_update_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_location_campaign_stats" (
    "id" SERIAL NOT NULL,
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "campaign_name" TEXT NOT NULL DEFAULT '',
    "website_id" INTEGER NOT NULL,
    "clicks" INTEGER,
    "datum" TIMESTAMP(3),
    "insertdate" TIMESTAMP(3),
    "average_position" DOUBLE PRECISION,
    "impressions" DOUBLE PRECISION,
    "average_cpc" DOUBLE PRECISION,
    "location_id" TEXT,
    "absolute_top_impression_percentage" DOUBLE PRECISION,
    "top_impression_percentage" DOUBLE PRECISION,

    CONSTRAINT "adwords_location_campaign_stats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_logindaten" (
    "id" SERIAL NOT NULL,
    "developerToken" TEXT,
    "userAgent" TEXT,
    "clientCustomerId" TEXT,
    "clientId" TEXT,
    "clientSecret" TEXT,
    "refreshToken" TEXT,
    "text" TEXT,

    CONSTRAINT "adwords_logindaten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_log_insert" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "date" TIMESTAMP(3),
    "typ" TEXT,
    "order_id" TEXT,

    CONSTRAINT "adwords_log_insert_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_mapdata_boundaries" (
    "id" SERIAL NOT NULL,
    "city_id" INTEGER,
    "lat" TEXT,
    "lng" TEXT,
    "polyg" INTEGER,
    "from_other_data" INTEGER DEFAULT 0,
    "land" TEXT,

    CONSTRAINT "adwords_mapdata_boundaries_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_mapdata_city" (
    "id" SERIAL NOT NULL,
    "Name" TEXT,
    "Name_en" TEXT,
    "Name_google" TEXT,
    "Land" TEXT,
    "placetype" TEXT,
    "object_id" TEXT,
    "gkz" TEXT,
    "plz" TEXT,
    "countPolygon" INTEGER NOT NULL,
    "level" TEXT,
    "parent_id" TEXT,
    "TargetType" TEXT,
    "from_other_data" INTEGER NOT NULL DEFAULT 0,
    "update_google" INTEGER NOT NULL DEFAULT 0,
    "all_postal" TEXT,
    "bundesland" TEXT,
    "hierachy" TEXT,
    "hierachyId" TEXT,
    "population" INTEGER NOT NULL DEFAULT 0,
    "wikidata" TEXT,
    "wikipage" TEXT,
    "prefix" TEXT,

    CONSTRAINT "adwords_mapdata_city_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_mapdata_null" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "insertdate" TIMESTAMP(3),
    "land" TEXT,

    CONSTRAINT "adwords_mapdata_null_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "adwords_tageszeit" (
    "id" SERIAL NOT NULL,
    "Tag" TEXT,
    "Tageszeit" INTEGER,
    "Kampagne" TEXT,
    "Anzeigengruppe" TEXT,
    "Klicks" INTEGER,
    "Impressionen" INTEGER,
    "CTR" TEXT,
    "DurchschnCPC" DOUBLE PRECISION,
    "Kosten" DOUBLE PRECISION,
    "DurchschnPosition" DOUBLE PRECISION,
    "KlicksmitConversion" DOUBLE PRECISION,
    "KostenKlickmitConversion" DOUBLE PRECISION,
    "KlickConversionRate" TEXT,
    "Conversions" INTEGER,
    "ViewthroughConv" TEXT,

    CONSTRAINT "adwords_tageszeit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "akr" (
    "id" SERIAL NOT NULL,
    "akr_bezahlt" INTEGER DEFAULT 0,
    "angebotsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "netto_preis_eu" TEXT,
    "brutto_preis_eu" TEXT,
    "waeh" TEXT,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "maxnum" INTEGER DEFAULT 0,
    "bea_verrechnet" INTEGER DEFAULT 0,
    "aktgesendet" INTEGER DEFAULT 0,
    "rechnung_bezahlt_date" TIMESTAMP(3),
    "rechnung_bezahlt_user" TEXT,
    "changeable" INTEGER DEFAULT 1,
    "hauptfirma" INTEGER,
    "firma" INTEGER,
    "freitext_header" TEXT,
    "freitext_last" TEXT,
    "rechnungsnummer_old" TEXT,
    "newrechnung_for_orgamax" INTEGER DEFAULT 0,
    "customer_id" INTEGER,

    CONSTRAINT "akr_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "akr_artikel" (
    "id" SERIAL NOT NULL,
    "akr_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "position_oben" INTEGER,
    "typ" INTEGER,
    "netto_preis_eu" TEXT,
    "konto" TEXT,
    "text" TEXT,

    CONSTRAINT "akr_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "analytics_log" (
    "id" SERIAL NOT NULL,
    "website_id" INTEGER,
    "created_at" TIMESTAMP(3),
    "datum" TEXT,
    "datum1" TIMESTAMP(3),
    "visits" INTEGER,
    "pageviews" INTEGER,
    "source" TEXT,
    "hostname" TEXT,
    "avgSessionDuration" TEXT,
    "SessionDuration" TEXT,
    "CPC" INTEGER,
    "CTR" INTEGER,

    CONSTRAINT "analytics_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "angebot" (
    "id" SERIAL NOT NULL,
    "angebotsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "bez1" TEXT,
    "gewaehlt" INTEGER DEFAULT 0,
    "maxnum" INTEGER DEFAULT 0,
    "verhandelt" INTEGER DEFAULT 0,
    "typ_for_check" TEXT,
    "aktgesendet" INTEGER DEFAULT 0,
    "netto_preis_eu" TEXT,
    "brutto_preis_eu" TEXT,
    "waeh" TEXT,
    "briefkopf" TEXT,
    "freitext_oben" TEXT,
    "freitext_unten" TEXT,
    "freitext_oben_id" INTEGER,
    "freitext_unten_id" INTEGER,
    "nullsteuersatz" INTEGER,

    CONSTRAINT "angebot_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "angebot_artikel" (
    "id" SERIAL NOT NULL,
    "angebot_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "netto_preis_eu" TEXT,
    "anzahl" DOUBLE PRECISION,
    "netto_preis_gesamt" TEXT,
    "netto_preis_eu_gesamt" TEXT,
    "position_oben" INTEGER,
    "brutto_preis" TEXT,
    "typ_art" INTEGER,
    "anmerkungen" TEXT,
    "reihenfolge" INTEGER,
    "display_typ" TEXT,
    "produkt_id" INTEGER,

    CONSTRAINT "angebot_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auftragsbestaetigung" (
    "id" SERIAL NOT NULL,
    "auftragsbestaetigungsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "angebot_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "bez1" TEXT,
    "gewaehlt" INTEGER DEFAULT 0,
    "maxnum" INTEGER DEFAULT 0,
    "verhandelt" INTEGER DEFAULT 0,
    "typ_for_check" TEXT,
    "aktgesendet" INTEGER DEFAULT 0,
    "netto_preis_eu" TEXT,
    "brutto_preis_eu" TEXT,
    "waeh" TEXT,
    "briefkopf" TEXT,
    "freitext_oben" TEXT,
    "freitext_unten" TEXT,
    "freitext_oben_id" INTEGER,
    "freitext_unten_id" INTEGER,
    "nullsteuersatz" INTEGER,

    CONSTRAINT "auftragsbestaetigung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "auftragsbestaetigung_artikel" (
    "id" SERIAL NOT NULL,
    "auftragsbestaetigung_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "netto_preis_eu" TEXT,
    "anzahl" DOUBLE PRECISION,
    "netto_preis_gesamt" TEXT,
    "netto_preis_eu_gesamt" TEXT,
    "position_oben" INTEGER,
    "brutto_preis" TEXT,
    "typ_art" INTEGER,
    "anmerkungen" TEXT,
    "reihenfolge" INTEGER,
    "display_typ" TEXT,
    "produkt_id" INTEGER,

    CONSTRAINT "auftragsbestaetigung_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "angebot_artikel_vorlage" (
    "id" SERIAL NOT NULL,
    "angebot_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "netto_preis_eu" TEXT,
    "anzahl" DOUBLE PRECISION,
    "netto_preis_gesamt" TEXT,
    "netto_preis_eu_gesamt" TEXT,
    "position_oben" INTEGER,
    "brutto_preis" TEXT,
    "typ_art" INTEGER,
    "anmerkungen" TEXT,
    "reihenfolge" INTEGER,
    "display_typ" TEXT,
    "produkt_id" INTEGER,

    CONSTRAINT "angebot_artikel_vorlage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "angebot_vorlage" (
    "id" SERIAL NOT NULL,
    "angebotsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "bez1" TEXT,
    "gewaehlt" INTEGER DEFAULT 0,
    "maxnum" INTEGER DEFAULT 0,
    "verhandelt" INTEGER DEFAULT 0,
    "typ_for_check" TEXT,
    "aktgesendet" INTEGER DEFAULT 0,
    "netto_preis_eu" TEXT,
    "brutto_preis_eu" TEXT,
    "waeh" TEXT,
    "briefkopf" TEXT,
    "freitext_oben" TEXT,
    "freitext_unten" TEXT,
    "freitext_oben_id" INTEGER,
    "freitext_unten_id" INTEGER,
    "nullsteuersatz" INTEGER,

    CONSTRAINT "angebot_vorlage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "anrufe_from_crm_log" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "date" TIMESTAMP(3),
    "typ" TEXT,
    "order_id" TEXT,

    CONSTRAINT "anrufe_from_crm_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "api_access_log" (
    "id" SERIAL NOT NULL,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ip" TEXT,
    "request" TEXT,
    "api_login_id" INTEGER,

    CONSTRAINT "api_access_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "api_logins" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "pw" TEXT,

    CONSTRAINT "api_logins_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aquiriert_save_log" (
    "id" SERIAL NOT NULL,
    "datum" TIMESTAMP(3),
    "user" TEXT,
    "order_id" INTEGER,

    CONSTRAINT "aquiriert_save_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "arbeitgeber" (
    "id" SERIAL NOT NULL,
    "spalte1" TEXT,
    "spalte2" TEXT,
    "kuerzel" TEXT,
    "verantwortlicher" TEXT,

    CONSTRAINT "arbeitgeber_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "artikel" (
    "id" SERIAL NOT NULL,
    "typ" TEXT,
    "typ_dt" TEXT,
    "typ_dt_english_for_proforma" TEXT,
    "name" TEXT,
    "name_help" TEXT,
    "info" TEXT,
    "preis" DOUBLE PRECISION,
    "name_no" TEXT,
    "name_tu" TEXT,
    "name_fr" TEXT,
    "name_ho" TEXT,
    "name_es" TEXT,
    "name_fin" TEXT,
    "name_eng" TEXT,
    "name_ch" TEXT,
    "an_eco" INTEGER NOT NULL,
    "an_exp" INTEGER NOT NULL,
    "an_expp" INTEGER NOT NULL,
    "default_fixpreis_euro_netto" DOUBLE PRECISION,
    "an_eco_ch" INTEGER NOT NULL,
    "an_exp_ch" INTEGER NOT NULL,
    "an_expp_ch" INTEGER NOT NULL,

    CONSTRAINT "artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "artikelnummern" (
    "id" SERIAL NOT NULL,
    "bearbeitungspauschale" INTEGER,
    "sonderrabatt" INTEGER,
    "gutschrift_analysekosten" INTEGER,
    "warenverkauf" INTEGER,
    "all_artikel_partner_oe_de" INTEGER,
    "all_artikel_partner_ch" INTEGER,
    "sonderrabatt_partner" INTEGER,
    "servicepauschale_partner_oe_de" INTEGER,
    "servicepauschale_partner_ch" INTEGER,

    CONSTRAINT "artikelnummern_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "artikelnummern_akt" (
    "id" SERIAL NOT NULL,
    "artikelnummer" TEXT,
    "konto_beschreibung" TEXT,

    CONSTRAINT "artikelnummern_akt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "artikel_analysekosten" (
    "id" SERIAL NOT NULL,
    "zahl" INTEGER,
    "datentraeger" TEXT,
    "service_art" TEXT,

    CONSTRAINT "artikel_analysekosten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aufgaben" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "auftragsnummer" TEXT,
    "kundennummer" TEXT,
    "kundenname" TEXT,
    "was" TEXT,
    "gruppe" INTEGER DEFAULT 0,
    "user" TEXT,
    "wann" TIMESTAMP(3),
    "created_at" TIMESTAMP(3),
    "erstellt_von" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "erledigt_von" TEXT,
    "geloescht_von" TEXT,
    "verschiebungsgrund" TEXT,
    "selbst_erstellt_von" TEXT,
    "priority" INTEGER,
    "aufgaben_typ_id" INTEGER DEFAULT 1,
    "is_anfrage" INTEGER DEFAULT 0,
    "powrbook_task_id" TEXT,

    CONSTRAINT "aufgaben_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "powrbook_connections" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "email" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "powrbook_connections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aufgabengruppen" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "verantwortlicher" TEXT,
    "aufgabenbereiche" TEXT,
    "teamleiter" TEXT,
    "aktiv" INTEGER DEFAULT 1,

    CONSTRAINT "aufgabengruppen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aufgabengruppen_user" (
    "aufgabengruppen_id" INTEGER,
    "user_id" INTEGER,
    "updated" INTEGER DEFAULT 0
);

-- CreateTable
CREATE TABLE "aufgaben_actions" (
    "id" SERIAL NOT NULL,
    "create_date" TIMESTAMP(3),
    "action" TEXT,
    "user" TEXT,
    "aufgabenid" INTEGER,
    "order_id" INTEGER,

    CONSTRAINT "aufgaben_actions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aufgaben_priority" (
    "id" SERIAL NOT NULL,
    "value" INTEGER NOT NULL,
    "text" TEXT,
    "color" TEXT,

    CONSTRAINT "aufgaben_priority_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aufgaben_statistik_log" (
    "id" SERIAL NOT NULL,
    "inserted_at" TIMESTAMP(3),
    "datum" TIMESTAMP(3),
    "anzahl" INTEGER,
    "aufgabengruppe_id" INTEGER,

    CONSTRAINT "aufgaben_statistik_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "aufgaben_typ" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "aufgaben_typ_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bearbeitungspauschale" (
    "id" SERIAL NOT NULL,
    "datentraeger" TEXT,
    "gratis_analyse" TEXT,
    "bezahlte_analyse" TEXT,
    "reihenfolge" INTEGER,

    CONSTRAINT "bearbeitungspauschale_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bereitschaftsnummern" (
    "id" SERIAL NOT NULL,
    "nummer" TEXT,
    "aktiv" TEXT,
    "land" TEXT,
    "name" TEXT,
    "bearbeiter" TEXT,
    "create_date" TIMESTAMP(3),
    "typ" TEXT,

    CONSTRAINT "bereitschaftsnummern_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "betreuer" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL DEFAULT '',
    "userid" INTEGER NOT NULL,

    CONSTRAINT "betreuer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bezeichnungen_uebersetzungen" (
    "id" SERIAL NOT NULL,
    "sprache" TEXT,
    "analysekosten_rechnung_oben" TEXT,
    "analysekosten_rechnung_unten" TEXT,
    "analysekosten_retourversand_oben" TEXT,
    "analysekosten_retourversand_unten" TEXT,
    "rechnung_oben" TEXT,
    "rechnung_unten" TEXT,
    "rechnung_unten_spezial" TEXT,
    "rueckversand_rechnung_oben" TEXT,
    "rueckversand_rechnung_unten" TEXT,
    "leihdatentraeger_rechnung_oben" TEXT,
    "leihdatentraeger_rechnung_unten" TEXT,
    "dienstleistung_oben" TEXT,
    "dienstleistung_unten" TEXT,
    "anzahlung_oben" TEXT,
    "anzahlung_unten" TEXT,
    "analyse_ergebnis_oben" TEXT,
    "analyse_ergebnis_unten" TEXT,
    "ratenzahlung_m_vereinbarung_oben" TEXT,
    "ratenzahlung_m_vereinbarung_unten" TEXT,
    "ratenzahlung_o_vereinbarung_oben" TEXT,
    "ratenzahlung_o_vereinbarung_unten" TEXT,
    "steuerschuld_oben" TEXT,
    "datum_text_pdf" TEXT,
    "steuerschuld_unten" TEXT,
    "rechnungsnummer_text_pdf" TEXT,
    "kundennummer_text_pdf" TEXT,
    "sachbearbeiter_text_pdf" TEXT,
    "position_text_pdf" TEXT,
    "anzahl_text_pdf" TEXT,
    "einheit_text_pdf" TEXT,
    "bezeichnung_text_pdf" TEXT,
    "einzelpreis_text_pdf" TEXT,
    "gesamtpreistext_pdf" TEXT,
    "kunde_text_pdf" TEXT,
    "ueberschrift_rechnungen" TEXT,
    "begrueßung_1" TEXT,
    "begrueßung_2" TEXT,
    "begrueßung_3" TEXT,
    "angebot_text_oben_1" TEXT,
    "angebot_text_oben_2" TEXT,
    "angebot_text_oben_3" TEXT,
    "angebotsnummer_text_pdf" TEXT,
    "angebot_text_unten_1" TEXT,
    "angebot_text_unten_2" TEXT,
    "angebot_text_unten_3" TEXT,
    "angebot_ueberschrift" TEXT,
    "bezeichnung_angebot_1" TEXT,
    "bezeichnung_angebot_2" TEXT,
    "bezeichnung_angebot_3" TEXT,
    "angebot_position_1" TEXT,
    "angebot_position_2" TEXT,
    "angebot_position_3" TEXT,
    "summe" TEXT,
    "mwst_text" TEXT,
    "gesamtbetrag_text" TEXT,
    "datenrettung_text" TEXT,
    "ueberschrift_analysekostenrechnung" TEXT,
    "ueberschrift_rueckversandrechnung" TEXT,
    "ueberschrift_leihdatentraegerrechnung" TEXT,
    "rvr_rechnung_bearbeitungspauschale" TEXT,
    "akr_rechnung_position_1" TEXT,
    "akr_rechnung_position_2" TEXT,
    "akr_rechnung_position_3" TEXT,
    "akr_rechnung_position_4" TEXT,
    "ueberschrift_zahlungserinnerung" TEXT,
    "mahnung_1_text_oben" TEXT,
    "rechnungsnummer_mahnung" TEXT,
    "datum_mahnung" TEXT,
    "offener_betrag_text" TEXT,
    "mahnung_faellig_text" TEXT,
    "mahnstufetext" TEXT,
    "mahngebuehr_text" TEXT,
    "mahnung_1_text_unten" TEXT,
    "mahnung_2_text_oben" TEXT,
    "mahnung_2_text_unten" TEXT,
    "mahnung_1_ueberschrift" TEXT,
    "mahnung_2_ueberschrift" TEXT,
    "letzte_mahnung_ueberschrift" TEXT,
    "letzte_mahnung_text_oben" TEXT,
    "letzte_mahnung_text_unten" TEXT,
    "mahnung_gruss_unten" TEXT,
    "gutschrift_text" TEXT,
    "gutschrift_nummer_text" TEXT,
    "gutschrift_ueberschrift" TEXT,
    "gutschrift_text_oben" TEXT,
    "gutschrift_text_unten" TEXT,
    "rabatt_text" TEXT,
    "versandblatt_text_oben" TEXT,
    "versandblatt_ueberschrift" TEXT,
    "versandblatt_text_unten" TEXT,
    "mahn_text2_2" TEXT,
    "versandblatt_wichtig_text" TEXT,
    "firmentext_rechnung_text" TEXT,
    "umsatzsteuernummer_txt" TEXT,
    "versandblatt_text_2" TEXT,
    "etikett_text" TEXT,
    "frachtbrief_text" TEXT,
    "auftragsblatt_text" TEXT,
    "tuer_text" TEXT,
    "angebot_verhandelt_text" TEXT,
    "angebot_leistungsbeschreibung_text" TEXT,
    "angebot_leistungsbeschreibung_text_1" TEXT,
    "agb_widerrufsbelehrung_text" TEXT,
    "int_haupsitz_text" TEXT,
    "buero_text" TEXT,
    "seite_text" TEXT,
    "leistungsort_text" TEXT,
    "steuer_text" TEXT,
    "proforma_rechnung_text_besch_1" TEXT,
    "proforma_rechnung_text_besch_2" TEXT,
    "proforma_rechnung_text_besch_3" TEXT,
    "proforma_rechnung_text_besch_4" TEXT,
    "proforma_rechnung_text_besch_5" TEXT,
    "proforma_rechnung_text_besch" TEXT,
    "proforma_rechnung_retour_text_besch" TEXT,
    "zusatz_rechnung_ohne_mwst_besch" TEXT,
    "zusatz_zahlungserinnerung_text_besch_1" TEXT,
    "zusatz_zahlungserinnerung_text_besch_2" TEXT,
    "zusatz_zahlungserinnerung_text_besch_3" TEXT,
    "zusatz_mahnung_text_1_besch" TEXT,
    "zusatz_mahnung_text_2_besch" TEXT,
    "footer_klagbar_besch" TEXT,
    "ueberschrift_ldt_preisliste_besch" TEXT,
    "preis_exkl_ust_besch" TEXT,
    "preis_inkl_ust_besch" TEXT,
    "preisliste_ldt_text_unten_besch" TEXT,
    "preisliste_dateiname_besch" TEXT,
    "endkundennummer_text_besch" TEXT,
    "partner_nr_text_besch" TEXT,
    "dt_art_text_besch" TEXT,
    "seriennummer_text_besch" TEXT,
    "volumen_text_besch" TEXT,
    "hersteller_text_besch" TEXT,
    "dauerrechnung_text_besch" TEXT,
    "dauerrechnung_start_text_besch" TEXT,
    "dauerrechnung_ende_text_besch" TEXT,
    "indiv_rech_text_besch" TEXT,
    "adresse_bank_text_besch" TEXT,
    "bankverbindung_text_besch" TEXT,
    "partner_rech_text_besch" TEXT,
    "partner_rech_text_besch_1" TEXT,
    "partner_lizenz_text_besch" TEXT,
    "partner_domain_text_besch" TEXT,
    "partner_domain_temp_text_besch" TEXT,
    "partner_domain_web_text_besch" TEXT,
    "partner_cloud_text_besch" TEXT,
    "partner_service_pausch_jaehr_text_besch" TEXT,
    "partner_add_ons_text_besch" TEXT,
    "partnerbuchhaltungsnummer_text_besch" TEXT,
    "partnerabw_infomail_betreff_text_besch" TEXT,
    "partnerabw_infomail_betreff_text_1_besch" TEXT,
    "partnerabw_infomail_betreff_text_2_besch" TEXT,
    "partnerabw_infomail_betreff_text_3_besch" TEXT,
    "partnerabw_infomail_text_besch" TEXT,

    CONSTRAINT "bezeichnungen_uebersetzungen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bezeichnungen_uebersetzungen_sms" (
    "id" SERIAL NOT NULL,
    "lang" TEXT,
    "auftrag_annahme_bez" TEXT,
    "zahlungseingang_bez" TEXT,
    "odt_versendet_bez" TEXT,
    "ldt_versendet_bez" TEXT,
    "akr_versendet_bez" TEXT,
    "ldt_rechnung_ver_bez" TEXT,
    "rv_rechnung_ver_bez" TEXT,
    "mahnung_bez" TEXT,
    "angebote_senden_bez" TEXT,
    "dr_annahme_bez" TEXT,
    "fileliste_ver_bez" TEXT,
    "dr_nicht_erfolgreich_bez" TEXT,
    "gutschrift_ver_bez" TEXT,
    "sms_rechnung_ver_bez" TEXT,
    "dhl_abholung_bez" TEXT,
    "tnt_abholung_bez" TEXT,
    "dt_eingetroffen_bez" TEXT,
    "rechnung_ver_bez" TEXT,

    CONSTRAINT "bezeichnungen_uebersetzungen_sms_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bingads_campaign" (
    "id" SERIAL NOT NULL,
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "campaign_name" TEXT NOT NULL DEFAULT '',
    "website_id" INTEGER NOT NULL,
    "aktiv" INTEGER DEFAULT 0,

    CONSTRAINT "bingads_campaign_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bingads_campaign_stats" (
    "id" SERIAL NOT NULL,
    "campaign_id" TEXT NOT NULL DEFAULT '',
    "campaign_name" TEXT NOT NULL DEFAULT '',
    "keyword_id" INTEGER NOT NULL,
    "website_id" INTEGER NOT NULL,
    "clicks" INTEGER,
    "cost" DOUBLE PRECISION,
    "datum" TIMESTAMP(3),
    "website_name" TEXT NOT NULL DEFAULT '',
    "insertdate" TIMESTAMP(3),
    "coversion_value" DOUBLE PRECISION,
    "converted_clicks" DOUBLE PRECISION,
    "average_position" DOUBLE PRECISION,
    "cost_per_conv_adwords" DOUBLE PRECISION,
    "impressions" DOUBLE PRECISION,
    "clicktype" TEXT NOT NULL DEFAULT '',
    "ad_group_id" TEXT NOT NULL DEFAULT '',
    "criteriatype" TEXT NOT NULL DEFAULT '',
    "slot" TEXT NOT NULL DEFAULT '',
    "companyname" TEXT NOT NULL DEFAULT '',
    "average_cpv" DOUBLE PRECISION,
    "average_cpc" DOUBLE PRECISION,
    "views" DOUBLE PRECISION,

    CONSTRAINT "bingads_campaign_stats_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "blocked_emails" (
    "id" SERIAL NOT NULL,
    "email" TEXT,
    "blocked_since" TIMESTAMP(3),
    "blocked_from" TEXT,
    "anzahl_blocked" INTEGER DEFAULT 0,
    "aktiv" INTEGER DEFAULT 0,

    CONSTRAINT "blocked_emails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bonusprovision_teamleiter_leads" (
    "id" SERIAL NOT NULL,
    "provision" DOUBLE PRECISION,
    "ab" DOUBLE PRECISION,
    "version" TEXT,

    CONSTRAINT "bonusprovision_teamleiter_leads_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bonusprovision_teamleiter_sales" (
    "id" SERIAL NOT NULL,
    "provision" DOUBLE PRECISION,
    "ab" DOUBLE PRECISION,
    "version" TEXT,

    CONSTRAINT "bonusprovision_teamleiter_sales_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "buchungen" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "customer_id" INTEGER,
    "partner_id" INTEGER,
    "typ" INTEGER,
    "buchhaltung_land" TEXT,
    "rechnungsnummer_for_up" TEXT,
    "Kontonummer" INTEGER,
    "Gegenkonto" INTEGER,
    "Rechnungsnummer" INTEGER,
    "Belegdatum" TEXT,
    "Valuttadatum" TEXT,
    "Waehrung" TEXT DEFAULT 'EUR',
    "Brutto" DECIMAL(65,30),
    "Netto" DECIMAL(65,30),
    "Steuer" DECIMAL(65,30),
    "Fremdwaehrung" TEXT,
    "Fremdwaehrung_soll" TEXT,
    "Fremdwaehrung_haben" TEXT,
    "Kostenstelle" INTEGER,
    "Belegkreis" TEXT,
    "Belegnummer" INTEGER,
    "UST_land" INTEGER,
    "UST_satz" INTEGER,
    "UST_code" INTEGER,
    "UST_sondercode" INTEGER,
    "buchungsart" INTEGER,
    "UID" TEXT,
    "Belegdatum_date" TIMESTAMP(3),
    "Valuttadatum_date" TIMESTAMP(3),

    CONSTRAINT "buchungen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "buchungen_archiv" (
    "id" SERIAL NOT NULL,
    "Kontonummer" INTEGER,
    "Gegenkonto" INTEGER,
    "Rechnungsnummer" INTEGER,
    "Belegdatum" INTEGER,
    "Valuttadatum" INTEGER,
    "Waehrung" TEXT DEFAULT 'EUR',
    "Brutto" DECIMAL(65,30),
    "Netto" DECIMAL(65,30),
    "Steuer" DECIMAL(65,30),
    "Fremdwaehrung" DECIMAL(65,30),
    "Fremdwaehrung_soll" DECIMAL(65,30),
    "Fremdwaehrung_haben" DECIMAL(65,30),
    "Kostenstelle" INTEGER,
    "Belegkreis" TEXT DEFAULT 'AR',
    "Belegnummer" INTEGER,
    "UST_land" INTEGER,
    "UST_satz" INTEGER,
    "UST_code" INTEGER,
    "UST_sondercode" INTEGER,
    "UST_buchungsart" INTEGER,
    "Belegdatum_date" TIMESTAMP(3),
    "Valuttadatum_date" TIMESTAMP(3),

    CONSTRAINT "buchungen_archiv_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "buchungen_person" (
    "id" SERIAL NOT NULL,
    "kontonummer" TEXT,
    "kontenart" TEXT,
    "fremdwährung" TEXT,
    "UID_Nummer" TEXT,
    "anrede" TEXT,
    "name" TEXT,
    "strasse" TEXT,
    "ort" TEXT,
    "mahnsperre" TEXT,
    "mahnrfist_1" TEXT,
    "mahnrfist_2" TEXT,
    "Mahnrfist_3" TEXT,
    "land" TEXT,
    "PLZ" TEXT,
    "Zusatztest" TEXT,
    "Kundennummer" TEXT,
    "Mahnschema" TEXT,
    "Zahlungsfrist_1" TEXT,
    "Zahlungsfrist_2" TEXT,

    CONSTRAINT "buchungen_person_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "buchungen_person_archiv" (
    "id" SERIAL NOT NULL,
    "Kontonummer" TEXT,
    "Kontenart" TEXT,
    "Fremdwährung" TEXT,
    "UID_Nummer" TEXT,
    "Anrede" TEXT,
    "Name" TEXT,
    "Straße" TEXT,
    "Ort" TEXT,
    "Mahnsperre" TEXT,
    "Mahnrfist_1" TEXT,
    "Mahnrfist_2" TEXT,
    "Mahnrfist_3" TEXT,
    "Land" TEXT,
    "PLZ" TEXT,
    "Zusatztest" TEXT,
    "Kundennummer" TEXT,
    "Mahnschema" TEXT,
    "Zahlungsfrist_1" TEXT,
    "Zahlungsfrist_2" TEXT,

    CONSTRAINT "buchungen_person_archiv_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contacts" (
    "id" SERIAL NOT NULL,
    "anfrage_was_ist_passiert" TEXT,
    "rueckruf_was_ist_passiert" TEXT,
    "partner_id" INTEGER,
    "aktiv" INTEGER DEFAULT 1,
    "vname" TEXT DEFAULT '-',
    "nname" TEXT DEFAULT '-',
    "prio" INTEGER DEFAULT 6,
    "email" TEXT,
    "nummer" TEXT,
    "mobil" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "firma" TEXT,
    "uid" TEXT,
    "anrede" TEXT,
    "anrede_num" TEXT,
    "str_nr" TEXT,
    "tuer_stock" TEXT,
    "plz" TEXT,
    "ort" TEXT,
    "land" TEXT,
    "rabatt_code" TEXT,
    "rabatt" TEXT,
    "send_sms" INTEGER,
    "send_mail" INTEGER,
    "titel" TEXT,
    "anmerkung" TEXT,
    "firmen_website" TEXT,
    "position" TEXT,
    "is_Rechnung" INTEGER DEFAULT 0,
    "website_anfrage" TEXT,
    "gruppen_id" INTEGER,
    "abteilungs_id" INTEGER,
    "lat" TEXT,
    "lng" TEXT,
    "uid_info" TEXT,
    "show_contact_abgabe" INTEGER DEFAULT 0,
    "adwords_region" TEXT,
    "birthday" TEXT,

    CONSTRAINT "contacts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contacts_customers" (
    "id" SERIAL NOT NULL,
    "coid" INTEGER,
    "cuid" INTEGER,
    "type" TEXT,

    CONSTRAINT "contacts_customers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contacts_partners" (
    "id" SERIAL NOT NULL,
    "coid" INTEGER,
    "cuid" INTEGER,
    "betid" INTEGER,
    "type" TEXT,
    "hauptkontakt_abgabestelle" INTEGER DEFAULT 0,

    CONSTRAINT "contacts_partners_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "contacts_save_log" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER,
    "vname" TEXT,
    "nname" TEXT,
    "prio" INTEGER DEFAULT 6,
    "email" TEXT,
    "nummer" TEXT,
    "mobil" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3),
    "firma" TEXT,
    "uid" TEXT,
    "anrede" TEXT,
    "str_nr" TEXT,
    "tuer_stock" TEXT,
    "plz" TEXT,
    "ort" TEXT,
    "land" TEXT,
    "rabatt_code" TEXT,
    "rabatt" TEXT,
    "send_sms" INTEGER,
    "send_mail" INTEGER,
    "titel" TEXT,
    "anmerkung" TEXT,
    "firmen_website" TEXT,
    "position" TEXT,
    "user" TEXT,
    "gruppen_id" INTEGER,
    "abteilungs_id" INTEGER,
    "anfrage_was_ist_passiert" TEXT,
    "rueckruf_was_ist_passiert" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "anrede_num" TEXT,
    "is_Rechnung" INTEGER DEFAULT 0,
    "website_anfrage" TEXT,
    "lat" TEXT,
    "lng" TEXT,
    "uid_info" TEXT,

    CONSTRAINT "contacts_save_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "customers" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER,
    "hauptfirma" INTEGER,
    "kundennummer" TEXT,
    "vname" TEXT,
    "nname" TEXT,
    "email" TEXT,
    "nummer" TEXT,
    "mobil" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "firma" TEXT,
    "uid" TEXT,
    "anrede" TEXT,
    "str_nr" TEXT,
    "tuer_stock" TEXT,
    "plz" TEXT,
    "ort" TEXT,
    "land" TEXT,
    "rabatt_code" TEXT,
    "rabatt" TEXT,
    "name_firma_abholung" TEXT,
    "ansprechperson_abholung" TEXT,
    "email_abholung" TEXT,
    "telefon_abholung" TEXT,
    "str_nr_abholung" TEXT,
    "tuer_stock_abholung" TEXT,
    "plz_abholung" TEXT,
    "ort_abholung" TEXT,
    "land_abholung" TEXT,
    "name_firma_zustellung" TEXT,
    "ansprechperson_zustellung" TEXT,
    "email_zustellung" TEXT,
    "telefon_zustellung" TEXT,
    "str_nr_zustellung" TEXT,
    "tuer_stock_zustellung" TEXT,
    "plz_zustellung" TEXT,
    "ort_zustellung" TEXT,
    "land_zustellung" TEXT,
    "send_sms" INTEGER,
    "send_mail" INTEGER,
    "titel" TEXT,
    "ansprechperson_1_anrede" TEXT,
    "ansprechperson_1_titel" TEXT,
    "ansprechperson_1_position" TEXT,
    "ansprechperson_1_vorname" TEXT,
    "ansprechperson_1_nachname" TEXT,
    "ansprechperson_1_telefon" TEXT,
    "ansprechperson_1_mobil" TEXT,
    "ansprechperson_1_email" TEXT,
    "ansprechperson_1_send_sms" INTEGER,
    "ansprechperson_1_send_mail" INTEGER,
    "ansprechperson_1_anmerkung" TEXT,
    "ansprechperson_2_anrede" TEXT,
    "ansprechperson_2_titel" TEXT,
    "ansprechperson_2_position" TEXT,
    "ansprechperson_2_vorname" TEXT,
    "ansprechperson_2_nachname" TEXT,
    "ansprechperson_2_telefon" TEXT,
    "ansprechperson_2_mobil" TEXT,
    "ansprechperson_2_email" TEXT,
    "ansprechperson_2_send_sms" INTEGER,
    "ansprechperson_2_send_mail" INTEGER,
    "ansprechperson_2_anmerkung" TEXT,
    "anmerkung" TEXT,
    "firmen_website" TEXT,
    "ohne_mwst" INTEGER DEFAULT 0,
    "partner_abhol_email" TEXT,
    "sprache" TEXT,

    CONSTRAINT "customers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "custom_order_sections" (
    "id" SERIAL NOT NULL,
    "heading" TEXT,
    "order" INTEGER,
    "is_header" INTEGER DEFAULT 0,
    "section_width" TEXT,
    "leitfaden_url" TEXT,

    CONSTRAINT "custom_order_sections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "custom_order_section_items" (
    "id" SERIAL NOT NULL,
    "section_id" INTEGER,
    "type_id" INTEGER,
    "name" TEXT,
    "order" INTEGER,
    "custom_column_width" TEXT,
    "required_for_task" INTEGER,

    CONSTRAINT "custom_order_section_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "custom_order_section_item_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "default_column_width" TEXT,

    CONSTRAINT "custom_order_section_item_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "custom_order_section_item_values" (
    "order_id" INTEGER,
    "item_id" INTEGER,
    "value" TEXT
);

-- CreateTable
CREATE TABLE "custom_order_section_select_options" (
    "id" SERIAL NOT NULL,
    "item_id" INTEGER,
    "select_option" TEXT,
    "order" INTEGER,

    CONSTRAINT "custom_order_section_select_options_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dashboard" (
    "id" SERIAL NOT NULL,
    "create_date" TIMESTAMP(3),
    "date" TIMESTAMP(3),
    "new_customer" INTEGER,
    "adspend" DOUBLE PRECISION,
    "orders" INTEGER,
    "euro_per_new_customer" DOUBLE PRECISION,
    "euro_per_order" DOUBLE PRECISION,
    "sales" DOUBLE PRECISION,
    "unique_not_answered" INTEGER,
    "unique_not_answered_callback_answered" INTEGER,
    "unique_not_answered_callback_not_answered" INTEGER,
    "income_not_answered_new_not_known" INTEGER,
    "average_reaction_time_leads" DOUBLE PRECISION,

    CONSTRAINT "dashboard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dashboard_user" (
    "id" SERIAL NOT NULL,
    "create_date" TIMESTAMP(3),
    "date" TIMESTAMP(3),
    "username" TEXT,
    "calltime" DOUBLE PRECISION,
    "percent_calltime_worktime" DOUBLE PRECISION,
    "worktime" DOUBLE PRECISION,
    "conversion_value" DOUBLE PRECISION,
    "percent_calls_filled" DOUBLE PRECISION,
    "count_new_calls" INTEGER,
    "count_nk" INTEGER,

    CONSTRAINT "dashboard_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "datentraeger" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "art" TEXT DEFAULT 'Festplatte',
    "art_de" TEXT,
    "art_experte" TEXT,
    "ursache" TEXT DEFAULT '-',
    "was_ist_passiert" TEXT DEFAULT '-',
    "partition" TEXT DEFAULT '-',
    "ordner" TEXT DEFAULT '-',
    "dateien" TEXT DEFAULT '-',
    "hersteller" TEXT,
    "size" TEXT,
    "type" TEXT,
    "seriennummer" TEXT,
    "dd_nummer" TEXT,
    "lagerort_auftrag" TEXT,
    "lagerort_datentraeger" TEXT,
    "lagerort_zubehoer" TEXT,
    "raid_level" TEXT,
    "zubehoer_1" TEXT,
    "zubehoer_2" TEXT,
    "zubehoer_3" TEXT,
    "zubehoer_4" TEXT,
    "analyseergebnis" TEXT,
    "mechanisch" INTEGER DEFAULT 0,
    "logisch" INTEGER DEFAULT 0,
    "offen" INTEGER DEFAULT 0,
    "dateneinsicht_analyse" INTEGER DEFAULT 0,
    "ursache_analyse_1" INTEGER DEFAULT 0,
    "ursache_analyse_1_preis" DOUBLE PRECISION,
    "analyseergebnis_sonstiges" TEXT,
    "ursache_analyse_2" INTEGER DEFAULT 0,
    "ursache_analyse_3" INTEGER DEFAULT 0,
    "ursache_analyse_4" INTEGER DEFAULT 0,
    "ursache_analyse_5" INTEGER DEFAULT 0,
    "ursache_analyse_6" INTEGER DEFAULT 0,
    "ursache_analyse_7" INTEGER DEFAULT 0,
    "ursache_analyse_8" INTEGER DEFAULT 0,
    "ursache_analyse_9" INTEGER DEFAULT 0,
    "wahrscheinlichkeit_rettung" INTEGER DEFAULT 95,
    "ursache_analyse_10" INTEGER DEFAULT 0,
    "ursache_analyse_11" INTEGER DEFAULT 0,
    "ursache_analyse_12" INTEGER DEFAULT 0,
    "ursache_analyse_13" INTEGER DEFAULT 0,
    "ursache_analyse_14" INTEGER DEFAULT 0,
    "ursache_analyse_15" INTEGER DEFAULT 0,
    "ursache_analyse_16" INTEGER DEFAULT 0,
    "ursache_analyse_17" INTEGER DEFAULT 0,
    "ursache_analyse_18" INTEGER DEFAULT 0,
    "e_ursache" TEXT,
    "e_was_ist_passiert" TEXT,
    "oeffnen_erlaubt" TEXT,
    "analyseergebnis_labor" TEXT,
    "analyseergebnis_sichtbar" INTEGER DEFAULT 0,
    "partner_analyse" TEXT,
    "mobil_pincode" TEXT,
    "donordrive_text" TEXT,
    "donordrive_preis" DOUBLE PRECISION,
    "donordrive_bestellt" TIMESTAMP(3),
    "donordrive_erhalten" TIMESTAMP(3),
    "passwort" TEXT,

    CONSTRAINT "datentraeger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "datentraeger_arten" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "is_raid" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "datentraeger_arten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "datentraeger_save_log" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "datentraeger_id" INTEGER,
    "order_id" INTEGER,
    "art" TEXT,
    "art_experte" TEXT,
    "ursache" TEXT,
    "was_ist_passiert" TEXT,
    "partition" TEXT,
    "ordner" TEXT,
    "dateien" TEXT,
    "hersteller" TEXT,
    "size" TEXT,
    "type" TEXT,
    "seriennummer" TEXT,
    "dd_nummer" TEXT,
    "lagerort_auftrag" TEXT,
    "lagerort_datentraeger" TEXT,
    "lagerort_zubehoer" TEXT,
    "raid_level" TEXT,
    "zubehoer_1" TEXT,
    "zubehoer_2" TEXT,
    "zubehoer_3" TEXT,
    "zubehoer_4" TEXT,
    "analyseergebnis" TEXT,
    "mechanisch" INTEGER DEFAULT 0,
    "logisch" INTEGER DEFAULT 0,
    "offen" INTEGER DEFAULT 0,
    "dateneinsicht_analyse" INTEGER DEFAULT 0,
    "ursache_analyse_1" INTEGER DEFAULT 0,
    "ursache_analyse_1_preis" DOUBLE PRECISION,
    "analyseergebnis_sonstiges" TEXT,
    "ursache_analyse_2" INTEGER DEFAULT 0,
    "ursache_analyse_3" INTEGER DEFAULT 0,
    "ursache_analyse_4" INTEGER DEFAULT 0,
    "ursache_analyse_5" INTEGER DEFAULT 0,
    "ursache_analyse_6" INTEGER DEFAULT 0,
    "ursache_analyse_7" INTEGER DEFAULT 0,
    "ursache_analyse_8" INTEGER DEFAULT 0,
    "ursache_analyse_9" INTEGER DEFAULT 0,
    "wahrscheinlichkeit_rettung" INTEGER DEFAULT 85,
    "ursache_analyse_10" INTEGER DEFAULT 0,
    "ursache_analyse_11" INTEGER DEFAULT 0,
    "ursache_analyse_12" INTEGER DEFAULT 0,
    "ursache_analyse_13" INTEGER DEFAULT 0,
    "ursache_analyse_14" INTEGER DEFAULT 0,
    "ursache_analyse_15" INTEGER DEFAULT 0,
    "ursache_analyse_16" INTEGER DEFAULT 0,
    "ursache_analyse_17" INTEGER DEFAULT 0,
    "ursache_analyse_18" INTEGER DEFAULT 0,
    "e_ursache" TEXT,
    "e_was_ist_passiert" TEXT,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "analyseergebnis_labor" TEXT,
    "analyseergebnis_sichtbar" INTEGER DEFAULT 0,
    "mobil_pincode" TEXT,
    "donordrive_text" TEXT,
    "donordrive_preis" DOUBLE PRECISION,
    "donordrive_bestellt" TIMESTAMP(3),
    "donordrive_erhalten" TIMESTAMP(3),
    "passwort" TEXT,

    CONSTRAINT "datentraeger_save_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "datentraeger_ursache" (
    "id" SERIAL NOT NULL,
    "datentraeger_id" INTEGER NOT NULL,
    "ursache_id" INTEGER NOT NULL,

    CONSTRAINT "datentraeger_ursache_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dhl_paketnummer" (
    "id" SERIAL NOT NULL,
    "tracking_number" TEXT,
    "confirmation_number" TEXT,
    "sender_name" TEXT,
    "pickup_date" TEXT,
    "pickup_time" TEXT,
    "country_code" TEXT,
    "order_id" INTEGER,
    "art" TEXT,
    "created_at" TIMESTAMP(3),
    "storniert_am" TIMESTAMP(3),
    "storniert_von" TEXT,
    "origin" TEXT,
    "destination" TEXT,
    "billing" TEXT,
    "empfaenger_daten" TEXT,
    "product_code" TEXT,
    "reference" TEXT,
    "identifier" TEXT,
    "gedruckt_am" TIMESTAMP(3),
    "gedruckt_von" TEXT,
    "gedruckt" INTEGER DEFAULT 0,
    "geloescht_von" TEXT,
    "standort_id" INTEGER NOT NULL DEFAULT 2,
    "delivery_date" TIMESTAMP(3),
    "delivery_time" TEXT,

    CONSTRAINT "dhl_paketnummer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dispo_places" (
    "id" SERIAL NOT NULL,
    "title" TEXT,
    "lat" TEXT,
    "lng" TEXT,
    "street" TEXT,
    "postal_code" TEXT,
    "place" TEXT,
    "country" TEXT,

    CONSTRAINT "dispo_places_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "diverses" (
    "id" SERIAL NOT NULL,
    "1_name" TEXT,
    "1_wert" TEXT,
    "2_name" TEXT,
    "2_wert" TEXT,
    "3_name" TEXT,
    "3_wert" TEXT,
    "4_name" TEXT,
    "4_wert" TEXT,
    "5_name" TEXT,
    "5_wert" TEXT,
    "6_name" TEXT,
    "6_wert" TEXT,
    "7_name" TEXT,
    "7_wert" TEXT,
    "rabattcode_anfrage_aktion" TEXT,
    "8_name" TEXT,
    "8_wert" TEXT,
    "aktion_datum" TIMESTAMP(3),
    "mail_telefonserver_sent" TIMESTAMP(3),
    "cookie_telefonnummer_tage" INTEGER DEFAULT 14,
    "deadline_add_eco" TEXT DEFAULT 'P0Y0M41DT0H0M0S',
    "deadline_add_exp" TEXT DEFAULT 'P0Y0M10DT0H0M0S',
    "deadline_add_expp" TEXT DEFAULT 'P0Y0M4DT0H0M0S',
    "nextcloud_path_crm_root" TEXT DEFAULT '../nextcloud/simplex/Simplex-CRM/auftraege',
    "compressed_image_path_crm_root" TEXT DEFAULT '../crm-images-compressed',

    CONSTRAINT "diverses_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "donordrives" (
    "id" INTEGER NOT NULL,
    "artikel_nr" TEXT,
    "order_id" INTEGER,
    "art" TEXT,
    "art_experte" TEXT,
    "ursache" TEXT,
    "hersteller" TEXT,
    "size" TEXT,
    "type" TEXT,
    "seriennummer" TEXT,
    "lagerort" TEXT,
    "electronics" TEXT,
    "external_case" INTEGER,
    "heads" TEXT,
    "motor" TEXT,
    "opened" INTEGER,
    "not_checked" INTEGER DEFAULT 0,

    CONSTRAINT "donordrives_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "donordrives_orgamax" (
    "ARTIKELNR" TEXT,
    "ARTIKELTEXT" TEXT,
    "ANMERKUNGEN" TEXT
);

-- CreateTable
CREATE TABLE "dpd_paketnummer" (
    "id" SERIAL NOT NULL,
    "parcel_nr" TEXT,
    "created_at" TIMESTAMP(3),
    "art" TEXT,
    "gedruckt" INTEGER DEFAULT 0,
    "gedruckt_von" TEXT,
    "gedruckt_am" TIMESTAMP(3),
    "geloescht_von" TEXT,
    "order_id" INTEGER,
    "standort_id" INTEGER NOT NULL DEFAULT 2,

    CONSTRAINT "dpd_paketnummer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "einwohner" (
    "id" SERIAL NOT NULL,
    "rang" TEXT,
    "name" TEXT,
    "EW" TEXT,
    "bundesland" TEXT,
    "land" TEXT,
    "ew_kategorie" TEXT,
    "lat" TEXT,
    "lng" TEXT,

    CONSTRAINT "einwohner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emails" (
    "id" SERIAL NOT NULL,
    "kundennummer" TEXT,
    "auftragsnummer" INTEGER,
    "mail_betreff" TEXT,
    "mail_text" TEXT,
    "order_id" INTEGER,
    "gesendet_am" TIMESTAMP(3),
    "bearbeiter" TEXT,
    "inaktiv" INTEGER DEFAULT 1,
    "anhang" TEXT,
    "gesendet_an" TEXT,
    "gesendet_von" TEXT,

    CONSTRAINT "emails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emails_customer" (
    "id" SERIAL NOT NULL,
    "kundennummer" TEXT,
    "mail_betreff" TEXT,
    "mail_text" TEXT,
    "gesendet_am" TIMESTAMP(3),
    "bearbeiter" TEXT,
    "inaktiv" INTEGER DEFAULT 1,
    "anhang" TEXT,
    "customer_id" INTEGER,
    "gesendet_an" TEXT,

    CONSTRAINT "emails_customer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emails_footer" (
    "id" SERIAL NOT NULL,
    "mail_text" TEXT,
    "bearbeitet_am" TIMESTAMP(3),
    "bearbeiter" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "firma_id" INTEGER,
    "konto_id" INTEGER,

    CONSTRAINT "emails_footer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emails_header" (
    "id" SERIAL NOT NULL,
    "mail_text" TEXT,
    "bearbeitet_am" TIMESTAMP(3),
    "bearbeiter" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "firma_id" INTEGER,
    "sms_text_vorlage" TEXT,

    CONSTRAINT "emails_header_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emails_partner" (
    "id" SERIAL NOT NULL,
    "partner_id" TEXT,
    "anfrage_id" INTEGER NOT NULL DEFAULT 0,
    "auftragsnummer" INTEGER,
    "mail_betreff" TEXT,
    "mail_text" TEXT,
    "order_id" INTEGER,
    "gesendet_am" TIMESTAMP(3),
    "bearbeiter" TEXT,
    "inaktiv" INTEGER DEFAULT 1,
    "anhang" TEXT,
    "gesendet_an" TEXT,

    CONSTRAINT "emails_partner_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emails_verwendung" (
    "id" SERIAL NOT NULL,
    "task" TEXT,
    "verwendung" TEXT,
    "name" TEXT,
    "name_sms" TEXT,
    "funktion" TEXT,

    CONSTRAINT "emails_verwendung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "emails_vorlagen" (
    "id" SERIAL NOT NULL,
    "mail_name" TEXT,
    "mail_betreff_name" TEXT,
    "mail_firma" TEXT,
    "mail_betreff" TEXT,
    "mail_text" TEXT,
    "bearbeitet_am" TIMESTAMP(3),
    "bearbeiter" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "firma_id" INTEGER,
    "manuell_auftrag" INTEGER DEFAULT 0,
    "manuell_anfrage" INTEGER DEFAULT 0,
    "user_id" INTEGER DEFAULT 0,
    "manuell_telefonliste" INTEGER DEFAULT 0,
    "manuell_email_partner" INTEGER DEFAULT 0,

    CONSTRAINT "emails_vorlagen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap" (
    "id" SERIAL NOT NULL,
    "insertdate" TIMESTAMP(3),
    "o365_uid" TEXT,
    "date" TIMESTAMP(3),
    "unread_crm" INTEGER DEFAULT 1,
    "type" TEXT,
    "encoding" TEXT,
    "folder" TEXT,
    "from_name" TEXT,
    "from_mail" TEXT,
    "from_mail_simple" TEXT,
    "to_name" TEXT,
    "to_mail" TEXT,
    "subj" TEXT,
    "text" TEXT,
    "cc" TEXT DEFAULT '',
    "bcc" TEXT,
    "dir" TEXT DEFAULT '',
    "dir1" TEXT,
    "uid" INTEGER,
    "unread" TEXT DEFAULT '',
    "answered" TEXT DEFAULT '0',
    "weitergeleitet" TEXT DEFAULT '0',
    "kontoid" INTEGER,
    "html" INTEGER,
    "order_id" INTEGER,
    "read_from" TEXT DEFAULT '',
    "read_date" TIMESTAMP(3),
    "status" INTEGER DEFAULT 0,
    "weiter_1" TEXT,
    "weiter_2" TEXT,
    "Spalte 30" INTEGER,
    "ist_neukunde" BOOLEAN,

    CONSTRAINT "email_imap_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap_actions" (
    "id" SERIAL NOT NULL,
    "create_date" TIMESTAMP(3),
    "action" TEXT,
    "user" TEXT,
    "emailid" INTEGER,

    CONSTRAINT "email_imap_actions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap_ausgang" (
    "id" SERIAL NOT NULL,
    "insertdate" TIMESTAMP(3),
    "date" TIMESTAMP(3),
    "folder" TEXT,
    "from_name" TEXT,
    "from_mail" TEXT,
    "from_mail_simple" TEXT,
    "to_name" TEXT,
    "to_mail" TEXT,
    "to_mail_simple" TEXT,
    "subj" TEXT,
    "text" TEXT,
    "cc" TEXT DEFAULT '',
    "bcc" TEXT,
    "dir" TEXT DEFAULT '',
    "dir1" TEXT,
    "uid" INTEGER,
    "kontoid" INTEGER,
    "html" INTEGER,
    "order_id" INTEGER,
    "send_from" TEXT DEFAULT '',
    "status" INTEGER,
    "weiter_1" TEXT DEFAULT '',
    "weiter_2" TEXT DEFAULT '',
    "ist_neukunde" BOOLEAN,

    CONSTRAINT "email_imap_ausgang_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap_ausgang_actions" (
    "id" SERIAL NOT NULL,
    "create_date" TIMESTAMP(3),
    "action" TEXT,
    "user" TEXT,
    "emailid" INTEGER,

    CONSTRAINT "email_imap_ausgang_actions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap_aus_email_konten" (
    "email_imap_ausgang_id" INTEGER,
    "email_imap_konten_id" INTEGER,
    "uid" TEXT
);

-- CreateTable
CREATE TABLE "email_imap_aus_email_mark" (
    "id" SERIAL NOT NULL,
    "email_imap_ausgang_id" INTEGER NOT NULL,
    "email_markierung_id" INTEGER NOT NULL,
    "user" TEXT,
    "created_at" TIMESTAMP(3),

    CONSTRAINT "email_imap_aus_email_mark_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap_email_konten" (
    "email_imap_id" INTEGER,
    "email_imap_konten_id" INTEGER,
    "uid" TEXT
);

-- CreateTable
CREATE TABLE "email_imap_email_mark" (
    "id" SERIAL NOT NULL,
    "email_imap_id" INTEGER NOT NULL,
    "email_markierung_id" INTEGER NOT NULL,
    "user" TEXT,
    "created_at" TIMESTAMP(3),

    CONSTRAINT "email_imap_email_mark_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap_files" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "email_imap_files_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_imap_konten" (
    "id" SERIAL NOT NULL,
    "postfach" TEXT,
    "postfach_name" TEXT,
    "user" TEXT,
    "pw" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "mailbox" TEXT,
    "sortierung" INTEGER,
    "last_uid" INTEGER,
    "land_id" INTEGER,
    "firma_id" INTEGER,
    "last_uid_outbox" INTEGER,
    "outboxfolder" TEXT,
    "type" TEXT,

    CONSTRAINT "email_imap_konten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "email_markierung" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "color" TEXT DEFAULT '#fff',
    "aufgabengruppen_id" INTEGER,
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "type" TEXT,
    "standard_markierung" INTEGER DEFAULT 0,

    CONSTRAINT "email_markierung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "endpoints" (
    "id" SERIAL NOT NULL,
    "contact_id" INTEGER,
    "endpoint_type" TEXT,
    "endpoint_subtype" TEXT,
    "endpoint_value" TEXT,
    "user" TEXT,

    CONSTRAINT "endpoints_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "faq" (
    "id" SERIAL NOT NULL,
    "frage" TEXT,
    "beantwortet" INTEGER DEFAULT 0,
    "create_date" TIMESTAMP(3),
    "user" TEXT DEFAULT '',
    "kategorien_id" TEXT DEFAULT '',
    "aktiv" INTEGER DEFAULT 1,

    CONSTRAINT "faq_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "faq_antworten" (
    "id" SERIAL NOT NULL,
    "faq_id" INTEGER,
    "antwort_typ" INTEGER DEFAULT 0,
    "antwort" TEXT,
    "create_date" TIMESTAMP(3),
    "user" TEXT,

    CONSTRAINT "faq_antworten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "faq_kategorien" (
    "id" SERIAL NOT NULL,
    "kategorie" TEXT NOT NULL,
    "sub_kategorie" INTEGER,
    "created_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3),
    "last_user" TEXT,

    CONSTRAINT "faq_kategorien_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fassadeninformationen" (
    "id" SERIAL NOT NULL,
    "typ" TEXT NOT NULL,
    "bezeichnung" TEXT NOT NULL,

    CONSTRAINT "fassadeninformationen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "firma" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "hauptfirma" INTEGER,
    "kundenfirma_land" INTEGER DEFAULT 0,
    "dr" INTEGER,
    "mwstextra" TEXT,
    "email" TEXT,
    "emailName" TEXT,
    "kuerzel" TEXT,
    "nehmen_for_land" INTEGER DEFAULT 0,
    "strasse" TEXT,
    "ort" TEXT,
    "includeMail" TEXT,
    "unterschrift" TEXT,
    "email_buchhaltung" TEXT,
    "emailName_buchhaltung" TEXT,
    "files" TEXT,
    "link_signatur" TEXT,
    "email_vorlagen_erlaubnis" TEXT,
    "land" TEXT,
    "google_account" TEXT,
    "google_client_secret" TEXT,
    "landkuerzel" TEXT,
    "lang" TEXT,
    "waeh" TEXT,
    "wae_k" TEXT,
    "faktor" TEXT,
    "sortierung" INTEGER,
    "land_partner" TEXT,
    "nummer_id" INTEGER,

    CONSTRAINT "firma_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "fixkosten" (
    "id" SERIAL NOT NULL,
    "firma" INTEGER,
    "fixkosten" TEXT,

    CONSTRAINT "fixkosten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gehalt_verlauf" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "jahr" INTEGER,
    "monat" INTEGER,
    "provision" DOUBLE PRECISION,
    "grundgehalt" DOUBLE PRECISION,

    CONSTRAINT "gehalt_verlauf_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "geschaeftszeiten" (
    "id" SERIAL NOT NULL,
    "land" TEXT,
    "land_name" TEXT,
    "tag" INTEGER,
    "tag_wort" TEXT,
    "start" TEXT,
    "ende" TEXT,

    CONSTRAINT "geschaeftszeiten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "google_client_id" (
    "id" SERIAL NOT NULL,
    "gclid" TEXT,
    "time" TIMESTAMP(3),
    "domain" TEXT,
    "ip_adresse" TEXT,
    "browser" TEXT,
    "betriebssystem" TEXT,
    "typ_id" INTEGER,

    CONSTRAINT "google_client_id_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "google_id_user_daten" (
    "id" SERIAL NOT NULL,
    "google_id" INTEGER,
    "user_daten_id" INTEGER,
    "created_at" TIMESTAMP(3),

    CONSTRAINT "google_id_user_daten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gps_logs" (
    "id" SERIAL NOT NULL,
    "lat" TEXT,
    "lng" TEXT,
    "gps_log_category_id" INTEGER,
    "username" TEXT,
    "contact_name" TEXT,
    "postal_code" TEXT,
    "street" TEXT,
    "town" TEXT,
    "note" TEXT,
    "created_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3),
    "address" TEXT,
    "priority" INTEGER,
    "happiness" INTEGER,

    CONSTRAINT "gps_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gps_log_categories" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "order" INTEGER,

    CONSTRAINT "gps_log_categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "group_recht" (
    "id" SERIAL NOT NULL,
    "gid" INTEGER,
    "rid" INTEGER,
    "recht" INTEGER,
    "rechtName" TEXT,
    "help" TEXT,

    CONSTRAINT "group_recht_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gruende_nicht_rettbar" (
    "id" SERIAL NOT NULL,
    "bezeichnung" TEXT NOT NULL,
    "text" TEXT,

    CONSTRAINT "gruende_nicht_rettbar_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "grundgehalt" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "gehalt" INTEGER,
    "ab_monat" INTEGER,
    "ab_jahr" INTEGER,
    "grundgehalt_rechnung" INTEGER DEFAULT 0,

    CONSTRAINT "grundgehalt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gutscheincodes" (
    "id" SERIAL NOT NULL,
    "betrag" TEXT NOT NULL DEFAULT '',
    "prozent" TEXT NOT NULL DEFAULT '',
    "ip" TEXT NOT NULL DEFAULT '',
    "abgelaufen" INTEGER NOT NULL DEFAULT 0,
    "ausgefuellt_at" TIMESTAMP(3) NOT NULL,
    "gueltig_bis" TIMESTAMP(3) NOT NULL,
    "gesendet_an" TEXT NOT NULL DEFAULT '',
    "gesendet_an_telefon" TEXT NOT NULL DEFAULT '',
    "webseite" TEXT NOT NULL DEFAULT '',
    "rabattcode" TEXT NOT NULL DEFAULT '',
    "gesendet_an_name" TEXT NOT NULL DEFAULT '',
    "created_at" TIMESTAMP(3) NOT NULL,
    "pruefsumme" TEXT NOT NULL,
    "ist_auftrag" TEXT,
    "created_by" TEXT,
    "recaptcha_response" TEXT,
    "aktion_gesendet_1" INTEGER DEFAULT 0,
    "aktion_gesendet_2" INTEGER DEFAULT 0,
    "aktion_gesendet_1_datum" TIMESTAMP(3) NOT NULL,
    "aktion_gesendet_2_datum" TIMESTAMP(3) NOT NULL,
    "rabatt_type" TEXT,

    CONSTRAINT "gutscheincodes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gutschrift" (
    "id" SERIAL NOT NULL,
    "gutschriftsnummer" TEXT DEFAULT '12341235',
    "rechnungsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "customer_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "maxnum" INTEGER DEFAULT 0,
    "netto_preis_eu" TEXT,
    "brutto_preis_eu" TEXT,
    "waeh" TEXT,
    "changeable" INTEGER DEFAULT 1,
    "changed_from" TEXT,
    "hauptfirma" INTEGER DEFAULT 1,
    "firma" INTEGER DEFAULT 1,
    "freitext_header" TEXT,
    "freitext_last" TEXT,
    "dauerrechnung" INTEGER,
    "dauerrechnung_start" TIMESTAMP(3),
    "dauerrechnung_ende" TIMESTAMP(3),
    "partner_id" INTEGER,
    "zusatztext_leistungsort" TEXT,
    "zusatztext_dienstleistung" TEXT,
    "zusatztext_indiv_recht" TEXT,
    "zusatztext_bankadresse" TEXT,
    "zusatztext_bankverbindung" TEXT,
    "zusatztext_steuer" TEXT,
    "check_zusatztext_leistungsort" INTEGER,
    "check_zusatztext_dienstleistung" INTEGER,
    "check_zusatztext_indiv_recht" INTEGER,
    "check_zusatztext_bankadresse" INTEGER,
    "check_zusatztext_bankverbindung" INTEGER,
    "check_zusatztext_steuer" INTEGER,
    "individuell" INTEGER DEFAULT 1,
    "newrechnung_for_orgamax" INTEGER DEFAULT 0,
    "rechnungsnummer_old" TEXT,

    CONSTRAINT "gutschrift_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "gutschrift_artikel" (
    "id" SERIAL NOT NULL,
    "gutschrift_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "netto_preis_eu" TEXT,
    "anzahl" DOUBLE PRECISION,
    "netto_preis_gesamt" TEXT,
    "netto_preis_gesamt_eu" TEXT,
    "brutto_preis" TEXT,
    "position_oben" INTEGER,
    "typ" INTEGER,
    "konto" TEXT,
    "text" TEXT,
    "bezeichnung1" TEXT,

    CONSTRAINT "gutschrift_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hauptfirma" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "buchhaltung" TEXT,
    "mwst" TEXT,
    "ustland" TEXT,
    "gf_user_id" INTEGER,
    "unsere_daten_id" INTEGER,

    CONSTRAINT "hauptfirma_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "help" (
    "id" SERIAL NOT NULL,
    "inhalt" TEXT,
    "datum" TIMESTAMP(3),
    "auftrag" INTEGER,
    "website" TEXT,

    CONSTRAINT "help_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "herkunft_auftrag" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "aktiv" INTEGER,

    CONSTRAINT "herkunft_auftrag_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "hochstufen_save_log" (
    "id" SERIAL NOT NULL,
    "datum" TIMESTAMP(3),
    "user" TEXT,
    "order_id" INTEGER,
    "s1" TEXT,
    "s2" TEXT,

    CONSTRAINT "hochstufen_save_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "images" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "base64_data" TEXT NOT NULL,

    CONSTRAINT "images_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "imap_konten_user" (
    "id" SERIAL NOT NULL,
    "konto_id" INTEGER,
    "user_id" INTEGER,

    CONSTRAINT "imap_konten_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "land_to_select" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "kuerzel" TEXT,
    "country_code" TEXT,
    "in_eu" INTEGER,
    "vorwahl" TEXT,
    "country_name" TEXT,
    "reihenfolge_email_verwaltung" INTEGER,
    "kuerzel_kundennummer" TEXT,
    "ust" DOUBLE PRECISION,
    "waehrung" TEXT,
    "language_short" TEXT,
    "language" TEXT,
    "sortierung" INTEGER,

    CONSTRAINT "land_to_select_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ldt_artikel" (
    "id" SERIAL NOT NULL,
    "rechnung_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "position_oben" INTEGER,
    "typ" INTEGER,
    "netto_preis_eu" TEXT,
    "update_date" TIMESTAMP(3),
    "text" TEXT,
    "konto" TEXT,

    CONSTRAINT "ldt_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ldt_log" (
    "id" SERIAL NOT NULL,
    "seriennummer" TEXT,
    "status" TEXT,
    "datum" TIMESTAMP(3),
    "order_id" INTEGER,
    "status_id" INTEGER,
    "leihdatentraeger_id" INTEGER,
    "verkauft" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "ldt_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ldt_rechnung" (
    "id" SERIAL NOT NULL,
    "rechnungsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "maxnum" INTEGER DEFAULT 0,
    "typ" INTEGER DEFAULT 0,
    "rechnungstyp" INTEGER,
    "ldt_rechnung_bezahlt" INTEGER DEFAULT 0,
    "ldt_rechnung_bezahlt_user" TEXT,
    "ldt_rechnung_bezahlt_date" TIMESTAMP(3),
    "netto_preis_eu" TEXT,
    "brutto_preis_eu" TEXT,
    "waeh" TEXT,
    "changeable" INTEGER DEFAULT 1,
    "hauptfirma" INTEGER,
    "firma" INTEGER,
    "bearbeiter_change" TEXT,
    "newrechnung_for_orgamax" INTEGER DEFAULT 0,
    "rechnungsnummer_old" TEXT,
    "customer_id" INTEGER,
    "freitext_header" TEXT,
    "freitext_last" TEXT,

    CONSTRAINT "ldt_rechnung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "leihdatentraeger" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL DEFAULT '',
    "preis" TEXT NOT NULL DEFAULT '',
    "aktiv" INTEGER DEFAULT 1,
    "einkaufspreis" INTEGER,
    "datum_einkaufspreis" TEXT,

    CONSTRAINT "leihdatentraeger_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "links" (
    "id" SERIAL NOT NULL,
    "webseite" TEXT,
    "link" TEXT,
    "name" TEXT,
    "User" TEXT,
    "passwort" TEXT,
    "kat1" TEXT,
    "kat2" TEXT,
    "kat3" TEXT,
    "partner_id" INTEGER,

    CONSTRAINT "links_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "links_menu" (
    "id" SERIAL NOT NULL,
    "link" TEXT,
    "link_display" TEXT,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "links_menu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "link_rechte" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "user_name" TEXT,
    "link_id" INTEGER NOT NULL,
    "sichtbar" TEXT DEFAULT '1',

    CONSTRAINT "link_rechte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "loading" (
    "id" SERIAL NOT NULL,
    "start" TIMESTAMP(3),
    "end" TIMESTAMP(3),
    "dauer" INTEGER,
    "user" TEXT,

    CONSTRAINT "loading_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "login_log" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "date" TIMESTAMP(3),
    "duration" TEXT,

    CONSTRAINT "login_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "messages" (
    "id" SERIAL NOT NULL,
    "to_user" TEXT,
    "typ" TEXT,
    "message" TEXT,
    "created" TIMESTAMP(3),

    CONSTRAINT "messages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "migrations" (
    "id" SERIAL NOT NULL,
    "migration" TEXT NOT NULL,
    "batch" INTEGER NOT NULL,

    CONSTRAINT "migrations_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "mobil_vorwahlen" (
    "id" SERIAL NOT NULL,
    "vorwahl" TEXT,
    "land" TEXT,

    CONSTRAINT "mobil_vorwahlen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "modules" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "enabled" INTEGER DEFAULT 0,
    "heading" TEXT,

    CONSTRAINT "modules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nc_directory_structure" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "display_order" INTEGER NOT NULL DEFAULT 0,
    "display_name" TEXT,
    "path" TEXT,
    "display_type" TEXT,

    CONSTRAINT "nc_directory_structure_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notizen" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "notiz" TEXT,
    "bearbeiter" TEXT,
    "art" TEXT,
    "aktiv" INTEGER,
    "update_date" TIMESTAMP(3),
    "bearbeiter_delete" TEXT,
    "notiz_art_g" TEXT,
    "priority" INTEGER,

    CONSTRAINT "notizen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notizen_partners" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "notiz" TEXT,
    "bearbeiter" TEXT,
    "art" TEXT,
    "aktiv" INTEGER,
    "update_date" TIMESTAMP(3),
    "bearbeiter_delete" TEXT,
    "anfrage_id" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "notizen_partners_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "not_scannt" (
    "id" SERIAL NOT NULL,
    "uhrzeit" TEXT,
    "input" TEXT,
    "user_id" INTEGER,
    "username" TEXT,
    "timestam" TIMESTAMP(3),

    CONSTRAINT "not_scannt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nummern" (
    "id" SERIAL NOT NULL,
    "typ" INTEGER,
    "nummer" TEXT,
    "nummer_gesamt" TEXT,
    "nummer_formatiert" TEXT,
    "nummer_anzeige_webseite" TEXT,
    "nummer_stadt" INTEGER DEFAULT 0,
    "land" TEXT,
    "ort" TEXT,
    "klingelton" TEXT,
    "hauptnummer" TEXT,
    "Failover Routing eingestellt" TEXT,
    "Route im Telefonserver eingestellt" TEXT,
    "durchwahl_mitsenden" INTEGER DEFAULT 1,
    "moh" TEXT DEFAULT 'mohLinz',
    "websites_id" INTEGER,
    "sprache" TEXT,

    CONSTRAINT "nummern_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nummern_anzeige_websites" (
    "id" SERIAL NOT NULL,
    "time" TIMESTAMP(3),
    "hauptnummer_id" INTEGER,
    "hauptnummer" TEXT,
    "nummer" TEXT,
    "nummer_show" TEXT,
    "vergeben" INTEGER DEFAULT 0,
    "vergeben_bis" TIMESTAMP(3),
    "gclid" TEXT,
    "zugeordnete_website_id" INTEGER,
    "bestandskunde_order_id" INTEGER,
    "vergeben_ab" TIMESTAMP(3),

    CONSTRAINT "nummern_anzeige_websites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "nummern_typ" (
    "id" SERIAL NOT NULL,
    "get_value_website" TEXT,
    "subdomain" TEXT,
    "text" TEXT,
    "forward_to" TEXT,

    CONSTRAINT "nummern_typ_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "objekte" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "art" TEXT,

    CONSTRAINT "objekte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders" (
    "id" SERIAL NOT NULL,
    "ordner_name" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL,
    "id_at" INTEGER,
    "partner_id" INTEGER,
    "nummern_typ_id" TEXT,
    "rechnung_bezahlt" INTEGER DEFAULT 0,
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "webseite" TEXT,
    "angebot" TEXT,
    "rechnung_bezahlt_teil" INTEGER DEFAULT 0,
    "service_art_dr" TEXT,
    "anfrage_to_auftrag_user" TEXT,
    "rueckruf_to_auftrag_user" TEXT,
    "aquiriert_von" TEXT,
    "user_before_analyseformular" TEXT,
    "hochgestuft_von" TEXT,
    "typ_der_DR" INTEGER NOT NULL DEFAULT 0,
    "rabatt_code" TEXT,
    "bearbeitungspauschale" INTEGER DEFAULT 0,
    "auftragsnummer" BIGINT NOT NULL,
    "anfragenummer" INTEGER NOT NULL DEFAULT 0,
    "rueckrufnummer" INTEGER NOT NULL DEFAULT 0,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "customer_id" INTEGER,
    "contact_id_anfrage" INTEGER,
    "contact_id_ruck" INTEGER,
    "datentraeger" TEXT,
    "nofdatentr" INTEGER DEFAULT 1,
    "problematik" TEXT,
    "service_art" TEXT,
    "wichtige_dateien" TEXT,
    "anmerkungen" TEXT,
    "eingangsdatum" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "kundenmeinung" TEXT,
    "ursache" TEXT,
    "service_art_old" TEXT,
    "dr_case_nr" TEXT,
    "abholung" TEXT DEFAULT '-',
    "abholung_datum" TEXT DEFAULT '-',
    "abholung_von" TEXT DEFAULT '-',
    "abholung_bis" TEXT DEFAULT '-',
    "send_sms" INTEGER,
    "send_mail" INTEGER,
    "lagerort_auftrag" TEXT,
    "lagerort_datentraeger" TEXT,
    "lagerort_zubehoer" TEXT,
    "casenumber1" TEXT,
    "casenumber2" TEXT,
    "leihdatentraeger" TEXT,
    "task_leihdatentraeger" TEXT,
    "firma" TEXT,
    "abholungsnummer" TEXT,
    "rueckversandgroesse" TEXT,
    "analysekosten_st" TEXT,
    "analysekosten_akt" TEXT,
    "analysekosten_dat" TIMESTAMP(3),
    "fileliste_user" TEXT,
    "fileliste_pw" TEXT,
    "abholung_key" TEXT,
    "conref" TEXT,
    "ref" TEXT,
    "leihdatentraeger_ser" TEXT,
    "rechnung_gesendet" INTEGER DEFAULT 0,
    "rechnung_date" TIMESTAMP(3),
    "rechnung_date_last" TIMESTAMP(3),
    "angebot_ohne_fixkosten" INTEGER DEFAULT 0,
    "akr_senden_erlaubt" INTEGER DEFAULT 0,
    "rechnung_bezahlt_date" TIMESTAMP(3),
    "rechnung_bezahlt_teil_date" TIMESTAMP(3),
    "user" TEXT,
    "test_form" INTEGER NOT NULL DEFAULT 0,
    "rechnung_bezahlt_user" TEXT,
    "rechnung_bezahlt_teil_user" TEXT,
    "rechnung_gesendet_user" TEXT,
    "help" INTEGER DEFAULT 0,
    "help_ablauf" TIMESTAMP(3),
    "help_ablauf_notiz" TEXT,
    "change_allow" INTEGER NOT NULL DEFAULT 1,
    "sid" INTEGER,
    "update_allow" INTEGER NOT NULL DEFAULT 1,
    "leihdatentraeger_ld1" TEXT,
    "leihdatentraeger_ld2" TEXT,
    "leihdatentraeger_ser_ld1" TEXT,
    "leihdatentraeger_ser_ld2" TEXT,
    "kundenmeinung_fertig" INTEGER DEFAULT 0,
    "merged_kundennummer" TEXT,
    "verantwortlicher" TEXT,
    "fixkosten" TEXT DEFAULT '50',
    "abholungsart_id" INTEGER DEFAULT 1,
    "provisionsmodell" TEXT,
    "einkaufskosten" DOUBLE PRECISION,
    "zahlungstyp" TEXT,
    "ratenzahlung_aktiv" INTEGER NOT NULL DEFAULT 0,
    "anfrage_to_auftrag_datum" TIMESTAMP(3),
    "ratenzahlung_aktiv_45_55" INTEGER DEFAULT 0,
    "auftrag_link1" TEXT,
    "auftrag_link2" TEXT,
    "herkunft" TEXT,
    "herkunft_keyword" TEXT,
    "annehmen_wait" INTEGER DEFAULT 1,
    "kontakt_vorher" TEXT,
    "warum_wir" TEXT,
    "warum_wir_individuell" TEXT,
    "ausgefuellt_beim_telefonat" INTEGER DEFAULT 0,
    "angebot_ohne_mail" INTEGER DEFAULT 0,
    "zusatzumsatz_hochstufung" TEXT DEFAULT '0',
    "keyword_schnittstelle" TEXT DEFAULT '0',
    "partner_interne_nummer" TEXT,
    "diverses_show" INTEGER NOT NULL DEFAULT 0,
    "hochstufung_datum" TIMESTAMP(3),
    "verkauft_von" TEXT,
    "rueckruf_to_auftrag_datum" TIMESTAMP(3),
    "daten_serbien_eingetroffen" INTEGER NOT NULL DEFAULT 0,
    "speicherort_datentraeger_serb" TEXT,
    "date_serb_save" TIMESTAMP(3),
    "stornierungsgrund" TEXT,
    "created_at_date" TIMESTAMP(3),
    "partner_kunde_war_auf_webseite" TEXT,
    "abgabe_bei_partner" INTEGER,
    "gesperrt" INTEGER DEFAULT 0,
    "freitext_header" TEXT,
    "ldt_gratis" INTEGER NOT NULL DEFAULT 0,
    "verantwortlicher_aufgabe" TEXT,
    "aufgabe_zeit" INTEGER NOT NULL DEFAULT 0,
    "last_status_ablauf1_date" TIMESTAMP(3),
    "aufgabe_grund" TEXT,
    "ldt_gratis_ld1" INTEGER NOT NULL DEFAULT 0,
    "ldt_gratis_ld2" INTEGER NOT NULL DEFAULT 0,
    "last_task_id" INTEGER,
    "last_task_date" TIMESTAMP(3),
    "last_status_ablauf1_id" INTEGER,
    "last_status_ablauf2_id" INTEGER,
    "last_status_ablauf2_date" TIMESTAMP(3),
    "rueckruf_from_asterisk" INTEGER DEFAULT 0,
    "gesperrt_sb_ok" INTEGER DEFAULT 0,
    "retour_versandart_id" INTEGER DEFAULT 1,
    "daten_leibold" INTEGER DEFAULT 0,
    "daten_leibold_gesendet" TIMESTAMP(3),
    "standort_id" INTEGER NOT NULL DEFAULT 2,
    "abgerechnet" INTEGER DEFAULT 0,
    "abgerechnet_date" TIMESTAMP(3),
    "grund_nicht_rettbar" INTEGER,
    "gclid" TEXT,
    "abgerechnet_pauschal" INTEGER NOT NULL DEFAULT 0,
    "raid_sms_sent" INTEGER DEFAULT 0,
    "lagerort_ldt" TEXT NOT NULL DEFAULT '',
    "lagerort_ldt1" TEXT NOT NULL DEFAULT '',
    "lagerort_ldt2" TEXT NOT NULL DEFAULT '',
    "verzichtet_gutschrift" TEXT NOT NULL DEFAULT '',
    "forschungslaborkosten" TEXT NOT NULL DEFAULT '',
    "potentialkanal" TEXT,
    "forschungslabor_bezahlt" INTEGER,
    "deadline_date" TIMESTAMP(3),
    "nur_klingeln_bei" TEXT,
    "anfrage_active_lead_generation" INTEGER,
    "anfrage_lead_from" TEXT,
    "provision_vermittlung" TEXT,
    "auftrag_zweites_telefonat" INTEGER,
    "channel" TEXT,
    "auftragsvolumen" TEXT,
    "geplanter_umsetzungszeitpunkt_jahr" TEXT,
    "geplanter_umsetzungszeitpunkt_quartal" TEXT,
    "baugenehmigung" TEXT,
    "netzzusage" TEXT,
    "foerderung" TEXT,
    "abwicklungsart" TEXT,
    "status_nachhack_zeitpunkt" TIMESTAMP(3),
    "nextcloud_share_link" TEXT,
    "kundenfeeling" TEXT,
    "kundenprioritaet" TEXT,
    "auftrag_produkt_art" TEXT,
    "created_by" TEXT,
    "angebot_freitext_oben_id" INTEGER,
    "angebot_freitext_unten_id" INTEGER,
    "mwst_frei" INTEGER,
    "anfrage_anzahl" TEXT,
    "anfrage_bauform" TEXT,
    "anfrage_lieferung" TEXT,
    "anfrage_wann" TEXT,
    "inquiry_assigned_to" TEXT,

    CONSTRAINT "orders_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders_notizen" (
    "order_id" INTEGER,
    "notiz_id" INTEGER,
    "art" TEXT,
    "sub_art" TEXT,
    "priority" INTEGER
);

-- CreateTable
CREATE TABLE "orders_save_log" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "auftragsnummer" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "customer_id" INTEGER,
    "datentraeger" TEXT,
    "nofdatentr" INTEGER,
    "problematik" TEXT,
    "wichtige_dateien" TEXT,
    "anmerkungen" TEXT,
    "eingangsdatum" TIMESTAMP(3),
    "webseite" TEXT,
    "kundenmeinung" TEXT,
    "ursache" TEXT,
    "service_art" TEXT,
    "partner_id" INTEGER,
    "dr_case_nr" TEXT,
    "angebot" TEXT,
    "abholung" TEXT,
    "abholung_datum" TEXT,
    "abholung_von" TEXT,
    "abholung_bis" TEXT,
    "send_sms" INTEGER,
    "send_mail" INTEGER,
    "lagerort_auftrag" TEXT,
    "lagerort_datentraeger" TEXT,
    "lagerort_zubehoer" TEXT,
    "casenumber1" TEXT,
    "casenumber2" TEXT,
    "leihdatentraeger" TEXT,
    "task_leihdatentraeger" TEXT,
    "rabatt_code" TEXT,
    "firma" TEXT,
    "abholungsnummer" TEXT,
    "rueckversandgroesse" TEXT,
    "analysekosten_st" TEXT,
    "analysekosten_akt" TEXT,
    "analysekosten_dat" TIMESTAMP(3),
    "fileliste_user" TEXT,
    "fileliste_pw" TEXT,
    "abholung_key" TEXT,
    "conref" TEXT,
    "ref" TEXT,
    "service_art_dr" TEXT,
    "leihdatentraeger_ser" TEXT,
    "angebot_ohne_fixkosten" INTEGER DEFAULT 0,
    "akr_senden_erlaubt" INTEGER DEFAULT 0,
    "leihdatentraeger_ld1" TEXT,
    "leihdatentraeger_ld2" TEXT,
    "leihdatentraeger_ser_ld1" TEXT,
    "leihdatentraeger_ser_ld2" TEXT,
    "verantwortlicher" TEXT,
    "verkauft_von" TEXT,
    "speicherort_datentraeger_serb" TEXT,
    "ldt_gratis" INTEGER NOT NULL DEFAULT 0,
    "ldt_gratis_ld1" INTEGER NOT NULL DEFAULT 0,
    "ldt_gratis_ld2" INTEGER NOT NULL DEFAULT 0,
    "retour_versandart_id" INTEGER DEFAULT 1,
    "daten_leibold" INTEGER DEFAULT 0,
    "daten_leibold_gesendet" TIMESTAMP(3),
    "grund_nicht_rettbar" INTEGER,
    "lagerort_ldt" TEXT NOT NULL DEFAULT '',
    "lagerort_ldt1" TEXT NOT NULL DEFAULT '',
    "lagerort_ldt2" TEXT NOT NULL DEFAULT '',
    "verzichtet_gutschrift" TEXT NOT NULL DEFAULT '',
    "forschungslaborkosten" TEXT NOT NULL DEFAULT '',
    "forschungslabor_bezahlt" INTEGER,
    "aquiriert_von" TEXT,

    CONSTRAINT "orders_save_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "orders_versendet" (
    "id" SERIAL NOT NULL,
    "von" TEXT,
    "an" TEXT,
    "order_id" TEXT,
    "timestamp" TIMESTAMP(3),

    CONSTRAINT "orders_versendet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "order_options" (
    "order_id" INTEGER,
    "name" TEXT,
    "value" TEXT
);

-- CreateTable
CREATE TABLE "order_texte" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "angebot_briefkopf" TEXT,
    "angebot_freitext_oben" TEXT,
    "angebot_freitext_unten" TEXT,

    CONSTRAINT "order_texte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "original_emails_vorlagen_mat" (
    "id" SERIAL NOT NULL,
    "mail_name" TEXT,
    "mail_betreff_name" TEXT,
    "mail_firma" TEXT,
    "mail_betreff" TEXT,
    "mail_text" TEXT,
    "bearbeitet_am" TIMESTAMP(3),
    "bearbeiter" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "firma_id" INTEGER,
    "manuell_auftrag" INTEGER DEFAULT 0,
    "manuell_anfrage" INTEGER DEFAULT 0,

    CONSTRAINT "original_emails_vorlagen_mat_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pages" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,

    CONSTRAINT "pages_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pakete" (
    "id" SERIAL NOT NULL,
    "Name" TEXT,
    "verfuegbarkeit" INTEGER,

    CONSTRAINT "pakete_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "parkplatz_preise" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "preis" INTEGER,
    "reihenfolge" INTEGER,

    CONSTRAINT "parkplatz_preise_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "parkplatz_preise_orders" (
    "order_id" INTEGER,
    "parkplatz_preis_id" INTEGER,
    "anzahl" INTEGER,
    "preis" DOUBLE PRECISION
);

-- CreateTable
CREATE TABLE "partnerportal_anfragen" (
    "id" SERIAL NOT NULL,
    "anfrage_text" TEXT NOT NULL,
    "vname" TEXT,
    "nname" TEXT,
    "telefon" TEXT,
    "email" TEXT,
    "created_at" TIMESTAMP(3),
    "partner_id" INTEGER,
    "order_id" INTEGER,
    "aktiv" INTEGER DEFAULT 1,
    "anfrage_or_rueckruf" INTEGER DEFAULT 0,
    "last_change" TIMESTAMP(3),
    "last_change_from" TEXT,

    CONSTRAINT "partnerportal_anfragen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partners" (
    "id" SERIAL NOT NULL,
    "partnervertrag_ausgefuellt_date" TIMESTAMP(3),
    "rechnung_bezahlt_date" TIMESTAMP(3),
    "partnervertrag_unterzeichnet_date" TIMESTAMP(3),
    "entgelt_rechnung_erstellt_date" TIMESTAMP(3),
    "partner_id" INTEGER,
    "partnernummer" TEXT,
    "partner_buchhaltungsnummer" TEXT,
    "is_abgabestelle" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "rabatt_code" TEXT,
    "rabatt" TEXT,
    "name_firma_abholung" TEXT,
    "str_nr_abholung" TEXT,
    "tuer_stock_abholung" TEXT,
    "plz_abholung" TEXT,
    "ort_abholung" TEXT,
    "land_abholung" TEXT,
    "name_firma_zustellung" TEXT,
    "str_nr_zustellung" TEXT,
    "tuer_stock_zustellung" TEXT,
    "plz_zustellung" TEXT,
    "ort_zustellung" TEXT,
    "land_zustellung" TEXT,
    "send_sms" INTEGER,
    "send_mail" INTEGER,
    "titel" TEXT,
    "anmerkung" TEXT,
    "firmen_website" TEXT,
    "partnerstufe" TEXT,
    "partner_user" TEXT,
    "partner_passwort" TEXT,
    "firmenbuch" TEXT,
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "partnerlizenz_entgelt" DOUBLE PRECISION DEFAULT 0,
    "website_erstellung_entgelt" DOUBLE PRECISION DEFAULT 0,
    "business_cloud_entgelt" DOUBLE PRECISION DEFAULT 0,
    "entgelt_sum" DOUBLE PRECISION DEFAULT 0,
    "jaehrliche_servicepauschale" DOUBLE PRECISION DEFAULT 0,
    "min_volumen_monatlich" DOUBLE PRECISION DEFAULT 0,
    "bestpreisgarantie" INTEGER NOT NULL DEFAULT 0,
    "beratung_und_zertifikat" INTEGER NOT NULL DEFAULT 0,
    "werbematerial" INTEGER NOT NULL DEFAULT 0,
    "jede_dr_express" INTEGER NOT NULL DEFAULT 0,
    "online_register" INTEGER NOT NULL DEFAULT 0,
    "pers_betreuer" INTEGER NOT NULL DEFAULT 0,
    "handling_mappe" INTEGER NOT NULL DEFAULT 0,
    "express_plus_je_dt" INTEGER NOT NULL DEFAULT 0,
    "webseite_inkl_domain" INTEGER NOT NULL DEFAULT 0,
    "anzahl_webseiten" INTEGER NOT NULL DEFAULT 0,
    "online_marketing" INTEGER NOT NULL DEFAULT 0,
    "anzahl_untersch_adwords" INTEGER NOT NULL DEFAULT 0,
    "gewuenschte_domains" TEXT,
    "analysefixkosten" TEXT DEFAULT '30',
    "preis_je_express_dt_input" DOUBLE PRECISION,
    "created_from" TEXT,
    "saved_from" TEXT,
    "erstes_passwort_klartext" TEXT,
    "partnervertrag_ausgefuellt" INTEGER NOT NULL DEFAULT 0,
    "aquiriert_oder_orgamax" INTEGER NOT NULL DEFAULT 0,
    "aquiriert_von" TEXT,
    "last_login" TIMESTAMP(3),
    "partner_entgelt_text" TEXT,
    "firmenstandorte_freitext" TEXT,
    "pick_up_service" INTEGER DEFAULT 0,
    "gebietsschutz" INTEGER DEFAULT 0,
    "exklusivrecht" INTEGER DEFAULT 0,
    "virtueller_server" INTEGER DEFAULT 0,
    "input_betriebssystem" TEXT,
    "anzahl_ip_adis" INTEGER DEFAULT 0,
    "partnervertrag_unterzeichnet" INTEGER DEFAULT 0,
    "check_add_ons" INTEGER DEFAULT 0,
    "partnerstufe_before_upgrade" TEXT,
    "upgrade_date" TIMESTAMP(3),
    "check_bcloud" INTEGER DEFAULT 0,
    "entgelt_rechnung_erstellt" INTEGER NOT NULL DEFAULT 0,
    "rechnung_bezahlt" INTEGER NOT NULL DEFAULT 0,
    "date_reg_orgamax" TEXT,
    "kdnr_orgamax" TEXT,
    "sonderrabatt" DOUBLE PRECISION DEFAULT 0,
    "jaehrliche_pauschale_auf_rech" INTEGER NOT NULL DEFAULT 0,
    "check_sonderrabatt" INTEGER NOT NULL DEFAULT 0,
    "check_offset_yearly_service_flat" INTEGER NOT NULL DEFAULT 0,
    "count_pv_created_infomail_send" INTEGER DEFAULT 0,
    "count_pv_signed_infomail_send" INTEGER DEFAULT 0,
    "count_prech_created_send_infomail_count" INTEGER DEFAULT 0,
    "count_prech_paid_send_infomail_count" INTEGER DEFAULT 0,
    "partnerschaft_beendet" TIMESTAMP(3),
    "kleinmedien_pauschale" INTEGER DEFAULT 10,
    "grossmedien_pauschale" INTEGER DEFAULT 30,
    "provision_vermittlung" INTEGER DEFAULT 20,
    "rabatt_auftragserteilung" INTEGER DEFAULT 20,
    "zugangsdaten_sent_at" TIMESTAMP(3),
    "silber_aktion" BOOLEAN DEFAULT false,
    "first_contact" TIMESTAMP(3),
    "first_contact_user" TEXT,
    "second_contact" TIMESTAMP(3),
    "second_contact_user" TEXT,
    "third_contact" TIMESTAMP(3),
    "third_contact_user" TEXT,
    "fourth_contact" TIMESTAMP(3),
    "fourth_contact_user" TEXT,
    "partnerschaft" TIMESTAMP(3),
    "pv_vollstaendig" TIMESTAMP(3),
    "partnertyp" TEXT DEFAULT 'Vertriebspartner',
    "webinar_datum" TIMESTAMP(3),
    "webinar_typ" TEXT,

    CONSTRAINT "partners_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partnerstufen" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "name_code" TEXT,
    "pick_up_service" INTEGER DEFAULT 0,
    "exklusivrecht" INTEGER DEFAULT 0,
    "sortierung" INTEGER,
    "provision_vermittlung" INTEGER NOT NULL DEFAULT 20,
    "rabatt_auftragserteilung" INTEGER NOT NULL DEFAULT 20,
    "Provision" DOUBLE PRECISION,
    "bestpreisgarantie" INTEGER DEFAULT 0,
    "erstschulung" INTEGER DEFAULT 0,
    "partnerregister" INTEGER DEFAULT 0,
    "werbematerial" INTEGER DEFAULT 0,
    "partner_lizenz_entgelt" DOUBLE PRECISION DEFAULT 0,
    "entgelt_summe" DOUBLE PRECISION DEFAULT 0,
    "jede_dr_exp" INTEGER DEFAULT 0,
    "express_plus_je_dt" INTEGER DEFAULT 0,
    "exp_plus_wert" DOUBLE PRECISION DEFAULT 0,
    "handling_mappe" INTEGER DEFAULT 0,
    "service_pauschale_jaehrlich" DOUBLE PRECISION DEFAULT 0,
    "persoenlicher_betreuer" INTEGER DEFAULT 0,
    "domain_only" INTEGER DEFAULT 0,
    "template_inkl_domain" INTEGER DEFAULT 0,
    "website_erstellung_entgelt" DOUBLE PRECISION DEFAULT 0,
    "business_cloud_entgelt" DOUBLE PRECISION DEFAULT 0,
    "anzahl_webseiten" INTEGER DEFAULT 0,
    "webseite_inkl_domain" INTEGER DEFAULT 0,
    "min_volumen_monatlich" DOUBLE PRECISION DEFAULT 0,
    "virtueller_server" INTEGER DEFAULT 0,
    "sonderrabatt" DOUBLE PRECISION DEFAULT 0,
    "formular_quick_forward" INTEGER DEFAULT 0,
    "festpreis_anzeigen" INTEGER DEFAULT 0,
    "gebietsschutz" INTEGER DEFAULT 0,
    "kleinmedien_pauschale" INTEGER DEFAULT 10,
    "grossmedien_pauschale" INTEGER DEFAULT 30,
    "kleinmedien_pauschale_chf" INTEGER DEFAULT 10,
    "grossmedien_pauschale_chf" INTEGER DEFAULT 30,
    "aktiv" INTEGER DEFAULT 1,

    CONSTRAINT "partnerstufen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partners_abgabestellen" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER NOT NULL,
    "abgabestelle_id" INTEGER NOT NULL,

    CONSTRAINT "partners_abgabestellen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partners_artikel" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER NOT NULL,
    "artikel_id" INTEGER NOT NULL,
    "preis_netto" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "preis_brutto" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "preis_netto_chf" DOUBLE PRECISION NOT NULL,
    "preis_brutto_chf" DOUBLE PRECISION NOT NULL,
    "show_artikel" INTEGER DEFAULT 1,

    CONSTRAINT "partners_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partners_save_log" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER,
    "partnernummer" TEXT,
    "partner_buchhaltungsnummer" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "rabatt_code" TEXT,
    "rabatt" TEXT,
    "name_firma_abholung" TEXT,
    "str_nr_abholung" TEXT,
    "tuer_stock_abholung" TEXT,
    "plz_abholung" TEXT,
    "ort_abholung" TEXT,
    "land_abholung" TEXT,
    "name_firma_zustellung" TEXT,
    "str_nr_zustellung" TEXT,
    "tuer_stock_zustellung" TEXT,
    "plz_zustellung" TEXT,
    "ort_zustellung" TEXT,
    "land_zustellung" TEXT,
    "send_sms" INTEGER,
    "send_mail" INTEGER,
    "titel" TEXT,
    "anmerkung" TEXT,
    "firmen_website" TEXT,
    "partnerstufe" TEXT,
    "partner_user" TEXT,
    "partner_passwort" TEXT,
    "firmenbuch" TEXT,
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "partnerlizenz_entgelt" DOUBLE PRECISION DEFAULT 0,
    "website_erstellung_entgelt" DOUBLE PRECISION DEFAULT 0,
    "business_cloud_entgelt" DOUBLE PRECISION DEFAULT 0,
    "entgelt_sum" DOUBLE PRECISION DEFAULT 0,
    "jaehrliche_servicepauschale" DOUBLE PRECISION DEFAULT 0,
    "min_volumen_monatlich" DOUBLE PRECISION DEFAULT 0,
    "bestpreisgarantie" INTEGER NOT NULL DEFAULT 0,
    "beratung_und_zertifikat" INTEGER NOT NULL DEFAULT 0,
    "werbematerial" INTEGER NOT NULL DEFAULT 0,
    "jede_dr_express" INTEGER NOT NULL DEFAULT 0,
    "online_register" INTEGER NOT NULL DEFAULT 0,
    "pers_betreuer" INTEGER NOT NULL DEFAULT 0,
    "handling_mappe" INTEGER NOT NULL DEFAULT 0,
    "express_plus_je_dt" INTEGER NOT NULL DEFAULT 0,
    "webseite_inkl_domain" INTEGER NOT NULL DEFAULT 0,
    "anzahl_webseiten" INTEGER NOT NULL DEFAULT 0,
    "template_inkl_domain" INTEGER NOT NULL DEFAULT 0,
    "domain_only" INTEGER NOT NULL DEFAULT 0,
    "kein_webauftritt" INTEGER NOT NULL DEFAULT 0,
    "online_marketing" INTEGER NOT NULL DEFAULT 0,
    "anzahl_untersch_adwords" INTEGER NOT NULL DEFAULT 0,
    "gewuenschte_domains" TEXT,
    "analysefixkosten" TEXT DEFAULT '30',
    "preis_je_express_dt_input" DOUBLE PRECISION,
    "created_from" TEXT,
    "saved_from" TEXT,
    "erstes_passwort_klartext" TEXT,
    "partnervertrag_ausgefuellt" INTEGER NOT NULL DEFAULT 0,
    "aquiriert_oder_orgamax" INTEGER NOT NULL DEFAULT 0,
    "aquiriert_von" TEXT,
    "last_login" TIMESTAMP(3),
    "partner_entgelt_text" TEXT,
    "firmenstandorte_freitext" TEXT,
    "pick_up_service" INTEGER DEFAULT 0,
    "gebietsschutz" INTEGER DEFAULT 0,
    "exklusivrecht" INTEGER DEFAULT 0,
    "virtueller_server" INTEGER DEFAULT 0,
    "input_betriebssystem" TEXT,
    "anzahl_ip_adis" INTEGER DEFAULT 0,
    "partnervertrag_unterzeichnet" INTEGER DEFAULT 0,
    "check_add_ons" INTEGER DEFAULT 0,
    "id_des_partners" INTEGER,
    "upgrade_date" TIMESTAMP(3),
    "partnerstufe_before_upgrade" TEXT,
    "bearbeiter" TEXT,
    "action" TEXT,
    "action_date" TIMESTAMP(3) NOT NULL,
    "is_abgabestelle" INTEGER,
    "check_bcloud" INTEGER DEFAULT 0,
    "date_reg_orgamax" TEXT,
    "kdnr_orgamax" TEXT,
    "sonderrabatt" DOUBLE PRECISION,
    "jaehrliche_pauschale_auf_rech" INTEGER DEFAULT 0,
    "check_sonderrabatt" INTEGER DEFAULT 0,
    "check_offset_yearly_service_flat" INTEGER DEFAULT 0,
    "partnerschaft_beendet" TIMESTAMP(3),
    "partnertyp" TEXT,
    "webinar_datum" TIMESTAMP(3),
    "webinar_typ" TEXT,

    CONSTRAINT "partners_save_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partnervertrag_texte_general" (
    "id" SERIAL NOT NULL,
    "sprache" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "text" TEXT NOT NULL,

    CONSTRAINT "partnervertrag_texte_general_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_abhol_adressen" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER NOT NULL,
    "firma" TEXT,
    "vname" TEXT,
    "nname" TEXT,
    "land" TEXT,
    "plz" TEXT,
    "ort" TEXT,
    "strasse" TEXT,
    "hausnr" TEXT,
    "tuer_stock" TEXT,
    "email" TEXT,
    "telefon" TEXT,
    "created_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "partner_abhol_adressen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_groups" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "partner_id" INTEGER,
    "show_name" TEXT,

    CONSTRAINT "partner_groups_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_groups_partners" (
    "group_id" INTEGER NOT NULL,
    "partners_id" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "partner_group_rechte" (
    "group_id" INTEGER NOT NULL,
    "rechte_id" INTEGER NOT NULL,
    "read_val" INTEGER,
    "insert_val" INTEGER,
    "update_val" INTEGER,
    "delete_val" INTEGER
);

-- CreateTable
CREATE TABLE "partner_inhalte" (
    "id" SERIAL NOT NULL,
    "image_url" TEXT,
    "texte_id" INTEGER,
    "content" TEXT,

    CONSTRAINT "partner_inhalte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_inhalte_partner" (
    "pid" INTEGER NOT NULL,
    "partner_inhalt_id" INTEGER NOT NULL,
    "art" TEXT,
    "server" TEXT NOT NULL DEFAULT 'P'
);

-- CreateTable
CREATE TABLE "partner_login_versuche" (
    "id" SERIAL NOT NULL,
    "partner_id" INTEGER NOT NULL,
    "time" TIMESTAMP(3),

    CONSTRAINT "partner_login_versuche_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_oeffnungszeiten" (
    "id" SERIAL NOT NULL,
    "wochentag_id" INTEGER NOT NULL,
    "partners_id" INTEGER NOT NULL,
    "start_zeit1" TEXT,
    "ende_zeit1" TEXT,
    "oeffnungs_art1" TEXT,
    "start_zeit2" TEXT,
    "ende_zeit2" TEXT,
    "oeffnungs_art2" TEXT,

    CONSTRAINT "partner_oeffnungszeiten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_provisionsmodelle" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "standard_abholung" TEXT,
    "standard_zustellung" TEXT,

    CONSTRAINT "partner_provisionsmodelle_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_provisionsmodelle_partners" (
    "id" SERIAL NOT NULL,
    "partners_id" INTEGER NOT NULL,
    "partner_provisionsmodell_id" INTEGER NOT NULL,
    "abholung_von" TEXT,
    "zustellung_zu" TEXT,
    "uhrzeit_von" TEXT,
    "uhrzeit_bis" TEXT,

    CONSTRAINT "partner_provisionsmodelle_partners_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_rechte" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "default_read" INTEGER NOT NULL DEFAULT 0,
    "default_insert" INTEGER NOT NULL DEFAULT 0,
    "default_update" INTEGER NOT NULL DEFAULT 0,
    "default_delete" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "partner_rechte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "partner_rechte_partners" (
    "rechte_id" INTEGER NOT NULL,
    "partners_id" INTEGER NOT NULL,
    "read_val" INTEGER DEFAULT 1,
    "insert_val" INTEGER DEFAULT 1,
    "update_val" INTEGER DEFAULT 1,
    "delete_val" INTEGER DEFAULT 1
);

-- CreateTable
CREATE TABLE "partner_stufen_modelle_service_art" (
    "partner_stufen_id" INTEGER NOT NULL,
    "service_art_id" INTEGER NOT NULL,
    "partner_provisionsmodelle_id" INTEGER,
    "allowed" INTEGER DEFAULT 0,
    "aufpreis" INTEGER DEFAULT 0,
    "rabatt_allowed" INTEGER DEFAULT 0,
    "selected_service_art" INTEGER DEFAULT 0
);

-- CreateTable
CREATE TABLE "pdf_daten" (
    "id" SERIAL NOT NULL,
    "sprache" TEXT,
    "pdf_typ" TEXT,
    "firmen_id" INTEGER,
    "header" TEXT,
    "header_endpoints" TEXT,
    "footer" TEXT,
    "logo_pfad" TEXT,
    "adresse_line" TEXT,
    "mail" TEXT,
    "logo_pfad_creditform" TEXT,
    "hauptnummer_id" INTEGER,
    "partner_land" TEXT,
    "header_html" TEXT NOT NULL,
    "footer_html" TEXT NOT NULL,

    CONSTRAINT "pdf_daten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "persoenliche_logins" (
    "id" SERIAL NOT NULL,
    "username_link" TEXT,
    "link" TEXT,
    "link_name" TEXT,
    "passwort" TEXT,
    "username" TEXT,

    CONSTRAINT "persoenliche_logins_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "personal_access_tokens" (
    "id" BIGINT NOT NULL,
    "tokenable_type" TEXT NOT NULL DEFAULT '0',
    "tokenable_id" BIGINT NOT NULL,
    "name" TEXT NOT NULL DEFAULT '0',
    "token" TEXT NOT NULL DEFAULT '0',
    "abilities" TEXT NOT NULL DEFAULT '0',
    "last_used_at" TIMESTAMP(3) NOT NULL,
    "expires_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "phpmailer" (
    "id" SERIAL NOT NULL,
    "email" TEXT,
    "mailvorlage" TEXT,
    "betreff" TEXT,
    "datum_to_send" TIMESTAMP(3),
    "webseite" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "anrede" TEXT,
    "ansprechperson" TEXT,
    "order_id" TEXT,
    "kundennummer" TEXT,
    "auftragsnummer" TEXT,
    "ohne_bezahlung" INTEGER,
    "typ" TEXT,
    "typ_of_mail" INTEGER,
    "versendet_von" TEXT,
    "email_persoenlich" TEXT,
    "from_name" TEXT,
    "indi_mail" TEXT,
    "anhang" TEXT,
    "typ_zahlungserinnerung" TEXT,
    "from" TEXT,
    "partner_id" INTEGER,

    CONSTRAINT "phpmailer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plz" (
    "id" SERIAL NOT NULL,
    "Gemeindekennziffer" TEXT,
    "Gemeindename" TEXT,
    "Gemeindecode" TEXT,
    "PLZ" TEXT,
    "weitere_PLZ" TEXT,

    CONSTRAINT "plz_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plz_ch" (
    "id" SERIAL NOT NULL,
    "Gemeindekennziffer" TEXT,
    "Gemeindename" TEXT,
    "Gemeindecode" TEXT,
    "PLZ" TEXT,
    "weitere_PLZ" TEXT,

    CONSTRAINT "plz_ch_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "plz_d" (
    "id" SERIAL NOT NULL,
    "Gemeindekennziffer" TEXT,
    "Gemeindename" TEXT,
    "Gemeindecode" TEXT,
    "PLZ" TEXT,
    "weitere_PLZ" TEXT,

    CONSTRAINT "plz_d_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "position" (
    "id" SERIAL NOT NULL,
    "bezeichnung" TEXT,

    CONSTRAINT "position_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produkt" (
    "id" SERIAL NOT NULL,
    "waschobjekt_id" INTEGER,
    "name" TEXT,
    "flaeche" INTEGER DEFAULT 0,
    "anmerkungen" TEXT,

    CONSTRAINT "produkt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produkt_texte" (
    "id" SERIAL NOT NULL,
    "sprache" TEXT,
    "produkt_id" INTEGER NOT NULL,
    "text" TEXT,

    CONSTRAINT "produkt_texte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "produkt_to_select" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "key" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "preis" DOUBLE PRECISION,
    "angebot_pdf_column_name" TEXT,
    "beschreibungs_text_column" TEXT,
    "garantie_algenbefall" INTEGER DEFAULT 0,
    "anmerkung_pre_fill_column_name" TEXT,
    "kontonummer" TEXT,
    "einkaufspreis" DOUBLE PRECISION,
    "einheit" TEXT,
    "kategorie" TEXT,
    "orgamax_artikelnummer" TEXT,
    "created_by" TEXT,

    CONSTRAINT "produkt_to_select_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "proforma_artikel" (
    "id" SERIAL NOT NULL,
    "rechnung_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "position_oben" INTEGER,
    "typ" INTEGER,

    CONSTRAINT "proforma_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "proforma_rechnung" (
    "id" SERIAL NOT NULL,
    "rechnungsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "maxnum" INTEGER DEFAULT 0,
    "waeh" TEXT,
    "partner_id" INTEGER,

    CONSTRAINT "proforma_rechnung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "provision" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "ab_monat" INTEGER,
    "ab_jahr" INTEGER,
    "probeflaeche_passiv" DOUBLE PRECISION NOT NULL DEFAULT 0.25,
    "probeflaeche_aktiv" DOUBLE PRECISION NOT NULL DEFAULT 1,
    "kein_auftrag_expp" DOUBLE PRECISION NOT NULL DEFAULT 2,
    "auftrag_eco" DOUBLE PRECISION NOT NULL DEFAULT 0.5,
    "geschaeftszeit_start" INTEGER,
    "geschaeftszeit_stop" INTEGER,
    "geschaeftszeit_tage" INTEGER,
    "auftrag_exp" DOUBLE PRECISION NOT NULL DEFAULT 1,
    "auftrag_expp" DOUBLE PRECISION NOT NULL DEFAULT 2,
    "eco_to_exp" DOUBLE PRECISION NOT NULL DEFAULT 2,
    "eco_to_expp" DOUBLE PRECISION NOT NULL DEFAULT 4,
    "exp_to_expp" DOUBLE PRECISION NOT NULL DEFAULT 3,
    "personenfaktor" DOUBLE PRECISION DEFAULT 10,
    "teamleiterfaktor" DOUBLE PRECISION DEFAULT 1,
    "bruttogehalt" DOUBLE PRECISION DEFAULT 0,
    "partner_aq_faktor" DOUBLE PRECISION DEFAULT 1,
    "laufend_bronze" DOUBLE PRECISION DEFAULT 0,
    "laufend_silber" DOUBLE PRECISION DEFAULT 10,
    "laufend_gold" DOUBLE PRECISION DEFAULT 20,
    "laufend_platin" DOUBLE PRECISION DEFAULT 20,
    "einmal_bronze" DOUBLE PRECISION DEFAULT 1,
    "einmal_silber" DOUBLE PRECISION DEFAULT 1,
    "einmal_gold" DOUBLE PRECISION DEFAULT 1,
    "einmal_platin" DOUBLE PRECISION DEFAULT 1,
    "einmal_bronze_mindest" DOUBLE PRECISION DEFAULT 0,
    "einmal_silber_mindest" DOUBLE PRECISION DEFAULT 150,
    "einmal_gold_mindest" DOUBLE PRECISION DEFAULT 350,
    "einmal_platin_mindest" DOUBLE PRECISION DEFAULT 0,
    "hoechstprovision" DOUBLE PRECISION DEFAULT 45,

    CONSTRAINT "provision_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "quadratmeterpreis" (
    "id" SERIAL NOT NULL,
    "produkt_id" INTEGER,
    "qm_groesser" INTEGER,
    "land" TEXT,
    "preis" DOUBLE PRECISION,

    CONSTRAINT "quadratmeterpreis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "raten" (
    "id" SERIAL NOT NULL,
    "rechnungsnummer" TEXT,
    "raten_nummer" INTEGER,
    "betrag" DOUBLE PRECISION,
    "bezahlt" INTEGER NOT NULL DEFAULT 0,
    "bezahlt_am" TIMESTAMP(3) NOT NULL,
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "anmerkung" TEXT NOT NULL,
    "order_id" INTEGER NOT NULL,
    "user" TEXT,

    CONSTRAINT "raten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "recall_routing" (
    "id" SERIAL NOT NULL,
    "nummer" TEXT,
    "username" TEXT,
    "created_at" TIMESTAMP(3),
    "telefon_income_id" INTEGER,
    "delete_date" TIMESTAMP(3),
    "username_kurz" TEXT,

    CONSTRAINT "recall_routing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rechnung" (
    "id" SERIAL NOT NULL,
    "rechnungsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "customer_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" DOUBLE PRECISION,
    "brutto_preis" DOUBLE PRECISION,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "maxnum" INTEGER DEFAULT 0,
    "netto_preis_eu" DOUBLE PRECISION,
    "waeh" TEXT,
    "brutto_preis_eu" DOUBLE PRECISION,
    "changeable" INTEGER DEFAULT 1,
    "individuell" INTEGER DEFAULT 0,
    "hauptfirma" INTEGER,
    "firma" INTEGER,
    "bezahlt" INTEGER DEFAULT 0,
    "freitext_header" TEXT,
    "freitext_last" TEXT,
    "dauerrechnung" INTEGER,
    "dauerrechnung_start" TIMESTAMP(3),
    "dauerrechnung_ende" TIMESTAMP(3),
    "partner_id" INTEGER,
    "zusatztext_leistungsort" TEXT,
    "zusatztext_dienstleistung" TEXT,
    "zusatztext_indiv_recht" TEXT,
    "zusatztext_bankadresse" TEXT,
    "zusatztext_bankverbindung" TEXT,
    "zusatztext_steuer" TEXT,
    "check_zusatztext_leistungsort" INTEGER,
    "check_zusatztext_dienstleistung" INTEGER,
    "check_zusatztext_indiv_recht" INTEGER,
    "check_zusatztext_bankadresse" INTEGER,
    "check_zusatztext_bankverbindung" INTEGER,
    "check_zusatztext_steuer" INTEGER,
    "netto_preis_eu_bezahlt" DOUBLE PRECISION DEFAULT 0,
    "brutto_preis_eu_bezahlt" DOUBLE PRECISION DEFAULT 0,
    "newrechnung_for_orgamax" INTEGER DEFAULT 0,
    "rechnungsnummer_old" TEXT,
    "auftragsbestaetigung_id" INTEGER,

    CONSTRAINT "rechnung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rechnungsnummern" (
    "id" SERIAL NOT NULL,
    "nummer" TEXT,
    "kuerzel" TEXT,
    "typ" TEXT,

    CONSTRAINT "rechnungsnummern_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rechnung_artikel" (
    "id" SERIAL NOT NULL,
    "rechnung_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "netto_preis_eu" TEXT,
    "anzahl" DOUBLE PRECISION,
    "netto_preis_gesamt" TEXT,
    "netto_preis_eu_gesamt" TEXT,
    "brutto_preis" TEXT,
    "position_oben" INTEGER,
    "typ" INTEGER,
    "konto" TEXT,
    "text" TEXT,
    "reihenfolge" INTEGER,

    CONSTRAINT "rechnung_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rechnung_extern" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "jahr" INTEGER,
    "monat" INTEGER,
    "betrag_berechnet" DOUBLE PRECISION,
    "betrag_in_rechnung_gestellt" DOUBLE PRECISION,

    CONSTRAINT "rechnung_extern_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rechnung_gesendet_orgamax" (
    "id" SERIAL NOT NULL,
    "send_date" TIMESTAMP(3),
    "emailtext" TEXT,
    "customer_id" INTEGER,
    "name" TEXT,
    "netto_preis" TEXT,
    "mwst_old" TEXT,
    "mwst_neu" TEXT,
    "brutto_old" TEXT,
    "brutto_neu" TEXT,
    "diff" TEXT,
    "rechnung" TEXT,
    "rechnungsnummer" TEXT,
    "kundennummer" TEXT,
    "rechnungsnummer_old" TEXT,

    CONSTRAINT "rechnung_gesendet_orgamax_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rechte_gruppen" (
    "id" SERIAL NOT NULL,
    "key" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "sort_order" INTEGER DEFAULT 0,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "rechte_gruppen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rechte" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "key" TEXT,
    "help" TEXT,
    "task_id" INTEGER,
    "gruppe_id" INTEGER,
    "sort_order" INTEGER DEFAULT 0,

    CONSTRAINT "rechte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rvr_artikel" (
    "id" SERIAL NOT NULL,
    "rechnung_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "bezeichnung" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "position_oben" INTEGER,
    "typ" INTEGER,
    "netto_preis_eu" TEXT,

    CONSTRAINT "rvr_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "rvr_rechnung" (
    "id" SERIAL NOT NULL,
    "rechnungsnummer" TEXT DEFAULT '12341235',
    "order_id" INTEGER,
    "create_date" TIMESTAMP(3),
    "referenz" TEXT,
    "bezeichnung" TEXT,
    "bearbeiter" TEXT,
    "netto_preis" TEXT,
    "brutto_preis" TEXT,
    "bearbeiter_delete" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "update_date" TIMESTAMP(3),
    "gesendet" INTEGER DEFAULT 0,
    "topdf" INTEGER DEFAULT 0,
    "faellig_am" TIMESTAMP(3),
    "maxnum" INTEGER DEFAULT 0,
    "rvr_rechnung_bezahlt" INTEGER DEFAULT 0,
    "rvr_rechnung_bezahlt_user" TEXT,
    "rvr_rechnung_bezahlt_date" TIMESTAMP(3),
    "netto_preis_eu" TEXT,
    "brutto_preis_eu" TEXT,
    "waeh" TEXT,
    "changeable" INTEGER DEFAULT 1,

    CONSTRAINT "rvr_rechnung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sales_statistik_variablen" (
    "id" SERIAL NOT NULL,
    "typ" TEXT,
    "auswahl" TEXT,
    "wert" TEXT,

    CONSTRAINT "sales_statistik_variablen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "schaeden" (
    "id" SERIAL NOT NULL,
    "waschobjekt_id" INTEGER,
    "wann" TEXT NOT NULL,
    "wobei" TEXT NOT NULL,
    "wer" TEXT NOT NULL,
    "beschreibung" TEXT NOT NULL,
    "email" TEXT,
    "erledigt" INTEGER,

    CONSTRAINT "schaeden_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "selectable_texts" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "text" TEXT NOT NULL,
    "select_name" TEXT NOT NULL,
    "user_id" INTEGER,
    "country_id" INTEGER,

    CONSTRAINT "selectable_texts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "select_kontakt_vorher" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "aktiv" INTEGER DEFAULT 1,

    CONSTRAINT "select_kontakt_vorher_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "select_warum_wir" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "code" TEXT,

    CONSTRAINT "select_warum_wir_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "settings" (
    "id" SERIAL NOT NULL,
    "version" TEXT,
    "themecolor" TEXT,
    "custom_topmenubuttons" INTEGER DEFAULT 0,
    "custom_images" INTEGER,
    "whatsapp_ultramsg_token" TEXT,
    "whatsapp_ultramsg_url" TEXT,
    "logo_name" TEXT,
    "nextcloud_url" TEXT,
    "crm_folder_path" TEXT,
    "akoro_inquiry_cronjob" INTEGER DEFAULT 0,
    "akoro_api_key" TEXT,
    "enable_address_popup" INTEGER DEFAULT 1,
    "websms_url" TEXT,
    "websms_user" TEXT,
    "websms_password" TEXT,
    "enable_akquiriert_von" TEXT,
    "enable_verkauft_von" TEXT,
    "enable_task_instant_mail_button" TEXT,
    "order_name_singular" TEXT,
    "order_name_plural" TEXT,
    "graph_clientid" TEXT,
    "graph_clientsecret" TEXT,
    "graph_tenantid" TEXT,
    "phone_3cx_url" TEXT DEFAULT '',
    "phone_3cx_api_key" TEXT DEFAULT '',
    "phone_asterisk_url" TEXT DEFAULT '',
    "phone_asterisk_user" TEXT DEFAULT '',
    "phone_asterisk_password" TEXT DEFAULT '',
    "phone_extension_prefix" TEXT DEFAULT '',
    "phone_extension_start" INTEGER DEFAULT 100,

    CONSTRAINT "settings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sidebar_left" (
    "id" SERIAL NOT NULL,
    "heading_1" TEXT,
    "heading_2" TEXT,
    "heading_3" TEXT,
    "heading_4" TEXT,
    "heading_5" TEXT,
    "heading_6" TEXT,
    "heading_7" TEXT,

    CONSTRAINT "sidebar_left_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sms_gesendet" (
    "id" SERIAL NOT NULL,
    "sms_text" TEXT,
    "order_id" INTEGER,
    "send_date" TIMESTAMP(3),
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "telefonnummer" TEXT,
    "anruf_incoming_id" INTEGER,
    "anruf_outgoing_id" INTEGER,

    CONSTRAINT "sms_gesendet_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sms_inbox" (
    "id" SERIAL NOT NULL,
    "nummer_id" INTEGER,
    "absender" TEXT,
    "sms_text" TEXT,
    "erhalten_am" TIMESTAMP(3),
    "order_id" INTEGER,
    "unread_crm" INTEGER DEFAULT 1,
    "status" INTEGER DEFAULT 0,
    "read_from" TEXT,
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "read_date" TIMESTAMP(3),

    CONSTRAINT "sms_inbox_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sms_inbox_actions" (
    "id" SERIAL NOT NULL,
    "user" TEXT,
    "create_date" TIMESTAMP(3),
    "action" TEXT,
    "sms_id" INTEGER NOT NULL,

    CONSTRAINT "sms_inbox_actions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sms_markierung_inbox" (
    "id" SERIAL NOT NULL,
    "sms_inbox_id" INTEGER,
    "email_markierung_id" INTEGER NOT NULL,
    "user" TEXT,
    "created_at" TIMESTAMP(3),

    CONSTRAINT "sms_markierung_inbox_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sms_nummern" (
    "id" SERIAL NOT NULL,
    "nummer" TEXT,
    "nummer_id" INTEGER,

    CONSTRAINT "sms_nummern_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sms_vorlagen" (
    "id" SERIAL NOT NULL,
    "firmen_id" INTEGER NOT NULL,
    "sms_name" TEXT NOT NULL,
    "sms_text" TEXT,
    "sms_land" TEXT,
    "bearbeiter" TEXT NOT NULL,
    "bearbeitet_am" TIMESTAMP(3),
    "aktiv" INTEGER NOT NULL DEFAULT 1,
    "manuell_anfrage" INTEGER NOT NULL DEFAULT 1,
    "manuell_auftrag" INTEGER NOT NULL DEFAULT 1,
    "manuell_anruf" INTEGER DEFAULT 1,
    "user_id" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "sms_vorlagen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "smtp_credentials" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "smtp_server" TEXT,
    "smtp_user" TEXT,
    "smtp_password" TEXT,
    "smtp_method" TEXT,
    "aktiv" INTEGER DEFAULT 0,
    "error_number" INTEGER DEFAULT 0,
    "priority" INTEGER,

    CONSTRAINT "smtp_credentials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "standorte" (
    "id" SERIAL NOT NULL,
    "company_name" TEXT,
    "adress_line" TEXT,
    "adress_line1" TEXT,
    "city" TEXT,
    "postal_code" TEXT,
    "country_code" TEXT,
    "country_name" TEXT,
    "person_name" TEXT,
    "phone_number" TEXT,
    "standard" INTEGER DEFAULT 0,

    CONSTRAINT "standorte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stati" (
    "id" SERIAL NOT NULL,
    "Name" TEXT NOT NULL DEFAULT '',
    "Name_Partner" TEXT NOT NULL,
    "aufgabengruppe" INTEGER,
    "prio" INTEGER,
    "nextStep" TEXT NOT NULL,
    "Ablauf" INTEGER,
    "Reihenfolge" INTEGER,
    "Gruppe" INTEGER,
    "days" INTEGER,
    "hours" INTEGER,
    "barcode_1" TEXT NOT NULL DEFAULT '',
    "barcode_2" TEXT NOT NULL DEFAULT '',
    "barcode_3" TEXT NOT NULL DEFAULT '',
    "barcode_4" TEXT NOT NULL DEFAULT '',
    "usergruppe" INTEGER DEFAULT 0,
    "aktiv" INTEGER DEFAULT 1,
    "manuell" INTEGER DEFAULT 1,
    "hauptverantwortlicher" INTEGER DEFAULT 1,
    "maximale_stati_im_verzug" INTEGER DEFAULT 10,
    "position_x" TEXT,
    "position_y" TEXT,
    "color" TEXT,

    CONSTRAINT "stati_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stati_verantwortlichkeiten" (
    "id" SERIAL NOT NULL,
    "status" INTEGER,
    "ablauf" INTEGER,
    "land" TEXT,
    "user" TEXT DEFAULT '3;27;',

    CONSTRAINT "stati_verantwortlichkeiten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "status_log" (
    "id" SERIAL NOT NULL,
    "auftrag" INTEGER,
    "ablauf" INTEGER,
    "status" INTEGER,
    "datum" TIMESTAMP(3),
    "user" TEXT,
    "not_ablauf" INTEGER DEFAULT 0,
    "from_other_crm" INTEGER DEFAULT 0,

    CONSTRAINT "status_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "status_log_archiv" (
    "id" SERIAL NOT NULL,
    "auftrag" INTEGER,
    "ablauf" INTEGER,
    "status" INTEGER,
    "datum" TIMESTAMP(3),
    "user" TEXT,
    "not_ablauf" INTEGER DEFAULT 0,

    CONSTRAINT "status_log_archiv_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "stornierungsgrund" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "code" TEXT,

    CONSTRAINT "stornierungsgrund_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "strasse" (
    "id" SERIAL NOT NULL,
    "PLZ" TEXT,
    "strasse" TEXT,
    "Ort" TEXT,

    CONSTRAINT "strasse_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tasks" (
    "id" SERIAL NOT NULL,
    "Aktion" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "help" TEXT,
    "dagingsvorherhin" TEXT,
    "next1" INTEGER,
    "next2" INTEGER,
    "next3" INTEGER,
    "next4" INTEGER,
    "next5" INTEGER,
    "next6" INTEGER,
    "next7" INTEGER,
    "next8" INTEGER,
    "next9" INTEGER,
    "next10" INTEGER,
    "order" INTEGER,
    "ablauf" INTEGER,
    "status_nach_klick" INTEGER,
    "system_person" INTEGER,
    "verantwortlich_at" TEXT DEFAULT '1;',
    "verantwortlich_de" TEXT DEFAULT '1;',
    "verantwortlich_tr" TEXT DEFAULT '1;',
    "verantwortlich_nl" TEXT DEFAULT '1;',
    "verantwortlich_no" TEXT DEFAULT '1;',
    "verantwortlich_ch" TEXT DEFAULT '1;',
    "verantwortlich_fin" TEXT DEFAULT '1;',
    "task_requires_upload" INTEGER DEFAULT 0,

    CONSTRAINT "tasks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "task_log" (
    "id" SERIAL NOT NULL,
    "auftrag" INTEGER,
    "ablauf" INTEGER,
    "task" INTEGER,
    "datum" TIMESTAMP(3),
    "user" TEXT,
    "return_allow" INTEGER,
    "from_other_crm" INTEGER,

    CONSTRAINT "task_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "task_log_archiv" (
    "id" SERIAL NOT NULL,
    "auftrag" INTEGER,
    "ablauf" INTEGER,
    "task" INTEGER,
    "datum" TIMESTAMP(3),
    "user" TEXT,
    "return_allow" INTEGER,

    CONSTRAINT "task_log_archiv_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "telefon_anrufer_typ" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "gruppierung" INTEGER,
    "anzeigen" INTEGER NOT NULL DEFAULT 1,
    "sortierung" INTEGER,
    "show_anspr_partner_abgabestelle" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "telefon_anrufer_typ_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "telefon_log_income" (
    "id" SERIAL NOT NULL,
    "call_date" TIMESTAMP(3),
    "anzahl" INTEGER,
    "anrufer" TEXT,
    "anrufer_name_vorhanden" TEXT,
    "anrufer_name_vorhanden_help" TEXT,
    "gew" TEXT,
    "answeredextension" TEXT,
    "answer_user" TEXT,
    "saved_user" TEXT,
    "klingdauer" INTEGER,
    "dauer" INTEGER,
    "anrufer_typ" TEXT,
    "anrufer_was_ist_passiert" TEXT,
    "calledextension" TEXT,
    "uniqueId" TEXT,
    "telefoniert_gerade" TEXT,
    "answertime" TIMESTAMP(3),
    "hanguptime" TIMESTAMP(3),
    "order_id" INTEGER DEFAULT 0,
    "test" TEXT,
    "anrufer_email" TEXT,
    "anrufer_name" TEXT,
    "was_macht_kunde" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "akt_stat" INTEGER,
    "order_id_anfragen" INTEGER,
    "partner_id" INTEGER,
    "kontakt_id" INTEGER,
    "dtart" TEXT,
    "typ" TEXT,
    "herkunft" TEXT,
    "keyword" TEXT,
    "verantwortlicher" TEXT,
    "call_date_date" TIMESTAMP(3),
    "order_id_rueck" INTEGER,
    "hot_aktiv" INTEGER DEFAULT 1,
    "last_speaker_name" TEXT,
    "last_speaker_ext" TEXT,
    "dont_record_call" INTEGER DEFAULT 0,
    "sms_gesendet" INTEGER DEFAULT 0,
    "sales_anruf" INTEGER DEFAULT 0,
    "destination_name" TEXT,
    "sent_after_hour_sms_to_gf" INTEGER DEFAULT 0,

    CONSTRAINT "telefon_log_income_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "telefon_log_income_called_extension" (
    "id" SERIAL NOT NULL,
    "telefon_log_income_id" INTEGER,
    "calledextension" TEXT,
    "created_at" TIMESTAMP(3),
    "uniqueid" TEXT DEFAULT '',
    "userid" INTEGER,
    "answered_at" TIMESTAMP(3),
    "channelname" TEXT,

    CONSTRAINT "telefon_log_income_called_extension_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "telefon_log_outgoing" (
    "id" SERIAL NOT NULL,
    "call_date" TIMESTAMP(3),
    "anzahl" INTEGER,
    "real_anrufer" TEXT,
    "anrufer_typ" TEXT,
    "anrufer" TEXT,
    "gew" TEXT,
    "angerufener_name_vorhanden" TEXT,
    "angerufener_name_vorhanden_help" TEXT,
    "uniqueId" TEXT,
    "anrufer_ext" TEXT,
    "anrufer_user" TEXT,
    "answertime" TIMESTAMP(3),
    "hanguptime" TIMESTAMP(3),
    "klingdauer" INTEGER,
    "dauer" INTEGER,
    "order_id" INTEGER DEFAULT 0,
    "angerufener_was_ist_passiert" TEXT,
    "calledextension" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "was_macht_kunde" TEXT,
    "angerufener_name" TEXT,
    "angerufener_email" TEXT,
    "order_id_anfragen" INTEGER,
    "partner_id" INTEGER,
    "kontakt_id" INTEGER,
    "dtart" TEXT,
    "typ" TEXT,
    "herkunft" TEXT,
    "keyword" TEXT,
    "saved_user" TEXT,
    "call_date_date" TIMESTAMP(3),
    "order_id_rueck" INTEGER,
    "help" INTEGER DEFAULT 0,
    "hot_aktiv" INTEGER DEFAULT 1,
    "dont_record_call" INTEGER DEFAULT 0,
    "sales_anruf" INTEGER DEFAULT 0,
    "sms_gesendet" INTEGER DEFAULT 0,

    CONSTRAINT "telefon_log_outgoing_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "telefon_log_save" (
    "id" SERIAL NOT NULL,
    "datum" TIMESTAMP(3),
    "income_id" INTEGER,
    "outgoing_id" INTEGER,
    "user" TEXT,
    "anrufer_typ" TEXT,
    "anrufer_was_ist_passiert" TEXT,
    "order_id" INTEGER,
    "order_id_anfrage" INTEGER,

    CONSTRAINT "telefon_log_save_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "telefon_moeglichkeiten" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "gruppierung" INTEGER,
    "hours" INTEGER DEFAULT 0,

    CONSTRAINT "telefon_moeglichkeiten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "testimonials" (
    "id" SERIAL NOT NULL,
    "type" TEXT,
    "video_source" TEXT,
    "image_source" TEXT,
    "second_image_source" TEXT,
    "text" TEXT,
    "customer_text" TEXT,
    "land_id" INTEGER,
    "content" TEXT,

    CONSTRAINT "testimonials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "testimonials_testimonial_types" (
    "testimonial_id" INTEGER,
    "testimonial_type_id" INTEGER
);

-- CreateTable
CREATE TABLE "testimonial_page" (
    "testimonial_id" INTEGER NOT NULL,
    "page_id" INTEGER NOT NULL,
    "website_id" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "created_by" TEXT,
    "order" INTEGER,
    "page_url" TEXT
);

-- CreateTable
CREATE TABLE "testimonial_types" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "alias" TEXT,
    "content" TEXT,

    CONSTRAINT "testimonial_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "texte" (
    "id" SERIAL NOT NULL,
    "sprache" TEXT,
    "ak_entsorgung_vorher" TEXT,
    "ak_entsorgung_nachher" TEXT,
    "ak_retourversand_vorher" TEXT,
    "ak_retourversand_nachher" TEXT,
    "rechnung_vorher" TEXT,
    "rechnung_nachher" TEXT,
    "rechnung_nachher_gratis" TEXT,
    "rvr_vorher" TEXT,
    "rvr_nachher" TEXT,
    "ldt_vorher" TEXT,
    "ldt_nachher" TEXT,
    "dienstleistung_vorher" TEXT,
    "dienstleistung_nachher" TEXT,
    "anzahlung_vorher" TEXT,
    "anzahlung_nachher" TEXT,
    "analyse_vorher" TEXT,
    "analyse_nachher" TEXT,
    "ratenzahlung_m_vereinbaarung_vorher" TEXT,
    "ratenzahlung_m_vereinbaarung_nachher" TEXT,
    "ratenzahlung_o_vereinbaarung_vorher" TEXT,
    "ratenzahlung_o_vereinbaarung_nachher" TEXT,
    "steuerschuld_vorher" TEXT,
    "steuerschuld_nachher" TEXT,
    "datum_text" TEXT,
    "rn_text" TEXT,
    "kn_text" TEXT,
    "sachbearbeiter_text" TEXT,
    "pos_text" TEXT,
    "anzahl_text" TEXT,
    "einheit_text" TEXT,
    "bez_text" TEXT,
    "einzelpreis_text" TEXT,
    "gesamtpreis_text" TEXT,
    "kunde_text" TEXT,
    "text_head" TEXT,
    "ansprech1" TEXT,
    "ansprech2" TEXT,
    "ansprech3" TEXT,
    "angebot1" TEXT,
    "angebot2" TEXT,
    "angebot3" TEXT,
    "an_text" TEXT,
    "angebot_text1" TEXT,
    "angebot_text1_gratis" TEXT,
    "angebot_text2" TEXT,
    "angebot_text_head" TEXT,
    "bez1" TEXT,
    "bez2" TEXT,
    "bez3" TEXT,
    "angebot_pos1" TEXT,
    "angebot_pos2" TEXT,
    "angebot_pos3" TEXT,
    "angebot_pos4" TEXT,
    "angebot_pos5" TEXT,
    "summe" TEXT,
    "mwst" TEXT,
    "gesamt" TEXT,
    "datenrettung_text" TEXT,
    "text_head_akr" TEXT,
    "text_head_rvr" TEXT,
    "text_head_ldt" TEXT,
    "rvr_text" TEXT,
    "akr_pos1" TEXT,
    "akr_pos2" TEXT,
    "akr_pos3" TEXT,
    "akr_pos4" TEXT,
    "zahler_pos1" TEXT,
    "mahn_text1" TEXT,
    "rn_text_grau" TEXT,
    "datum_grau" TEXT,
    "mah_o_betrag_text" TEXT,
    "mah_faellig" TEXT,
    "mah_stufe_text" TEXT,
    "mahnGebuehr_text" TEXT,
    "mahn_text1_2" TEXT,
    "mfg_text" TEXT,
    "mahn_text2" TEXT,
    "mahn_text2_2" TEXT,
    "erste_mah_ueber" TEXT,
    "zweite_mah_ueber" TEXT,
    "letzte_mah_ueber" TEXT,
    "mahn_text3" TEXT,
    "mahn_text3_3" TEXT,
    "mah_team" TEXT,
    "gutschrift" TEXT,
    "gutschrift_nr_text" TEXT,
    "gutschrift_ueber" TEXT,
    "gutschrift_text" TEXT,
    "gutschrift_last_text" TEXT,
    "rabatt_vereinbarung" TEXT,
    "packungsbeilage_text" TEXT,
    "versandblatt_text" TEXT,
    "versandblatt_wichtig" TEXT,
    "firmentext_rechnung" TEXT,
    "umsatzsteuernummer" TEXT,
    "Versandblatt" TEXT,
    "Etikett" TEXT,
    "Frachtbrief" TEXT,
    "Auftragsblatt" TEXT,
    "tuer" TEXT,
    "angebot_verhandelt" TEXT,
    "angebot_leistungsbeschreibung" TEXT,
    "angebot_leistungsbeschreibung_1" TEXT,
    "agb_widerrufsbelehrung" TEXT,
    "int_hauptsitz" TEXT,
    "buero" TEXT,
    "seite" TEXT,
    "leistungsort" TEXT,
    "steuer" TEXT,
    "performa_rechnung_text_1" TEXT,
    "performa_rechnung_text_2" TEXT,
    "performa_rechnung_text_3" TEXT,
    "performa_rechnung_text_4" TEXT,
    "performa_rechnung_text_5" TEXT,
    "performa_rechnung_text_6" TEXT,
    "performa_rechnung" TEXT,
    "performa_rechnung_retour" TEXT,
    "zusatz_rechnung_ohne_mwst" TEXT,
    "zusatz_zahlungserinnerung_text_1" TEXT,
    "zusatz_zahlungserinnerung_text_2" TEXT,
    "zusatz_zahlungserinnerung_text_3" TEXT,
    "zusatz_mahnung_text_1" TEXT,
    "zusatz_mahnung_text_2" TEXT,
    "footer_klagbar" TEXT,
    "ueberschrift_ldt_preisliste" TEXT,
    "preis_exkl_ust" TEXT,
    "preis_inkl_ust" TEXT,
    "preisliste_ldt_text_unten" TEXT,
    "preisliste_dateiname" TEXT,
    "endkundennummer_text_pdf" TEXT,
    "partner_nr_text_pdf" TEXT,
    "dt_art_text" TEXT,
    "seriennummer_text" TEXT,
    "volumen_text" TEXT,
    "hersteller_text" TEXT,
    "schweiz_ohne_mwst" TEXT,
    "endkundenname_text" TEXT,
    "auftragsnummer_text" TEXT,
    "dauerrechnung_text" TEXT,
    "dauerrechnung_start_text" TEXT,
    "dauerrechnung_ende_text" TEXT,
    "partner_lizenz_text" TEXT,
    "partner_domain_text" TEXT,
    "partner_domain_temp_text" TEXT,
    "partner_domain_web_text" TEXT,
    "partner_cloud_text" TEXT,
    "partner_service_pausch_jaehr_text" TEXT,
    "partner_add_ons_text" TEXT,
    "indiv_rech_text" TEXT,
    "adresse_bank_text" TEXT,
    "bankverbindung_text" TEXT,
    "partner_rech_text" TEXT,
    "partner_rech_text_1" TEXT,
    "partnerbuchhaltungsnummer_text" TEXT,
    "partnerabw_infomail_betreff_text" TEXT,
    "partnerabw_infomail_betreff_text_1" TEXT,
    "partnerabw_infomail_betreff_text_2" TEXT,
    "partnerabw_infomail_betreff_text_3" TEXT,
    "partnerabw_infomail_text" TEXT,
    "gueltigkeit" TEXT,
    "angebot_komplett_pdf" TEXT,
    "angebot_real_pdf" TEXT,
    "angebot_natural_pdf" TEXT,
    "angebot_metall_pdf" TEXT,
    "produkt_beschr_komplett" TEXT,
    "produkt_beschr_real" TEXT,
    "produkt_beschr_natural" TEXT,
    "produkt_beschr_metal" TEXT,
    "angebot_allgemein_garantie" TEXT,
    "angebot_allgemein_rechtliches" TEXT,
    "angebot_allgemein_vorteile" TEXT,
    "rechnung_zahlungsinfo" TEXT,
    "rechnung_bankverbindung" TEXT,
    "pdf_footer" TEXT,
    "gutschrift_zahlungsinfo" TEXT,
    "angebot_einleitung" TEXT,
    "rechnung_einleitung" TEXT,
    "angebot_garantie_algenbefall" TEXT,
    "pdf_header" TEXT,
    "produkt_anmerkung_glasreinigung" TEXT,
    "produkt_anmerkung_glasrahmenreinigung" TEXT,
    "produkt_anmerkung_storenreinigung" TEXT,
    "produkt_anmerkung_hydrophobierung" TEXT,
    "produkt_anmerkung_metallauffrischung" TEXT,
    "produkt_anmerkung_dachreinigung" TEXT,
    "angebot_freitext_oben" TEXT,
    "angebot_freitext_unten" TEXT,
    "nullsteuersatz" TEXT,

    CONSTRAINT "texte_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "texte_titel" (
    "id" SERIAL NOT NULL,
    "AT" TEXT,
    "EN" TEXT,
    "CH" TEXT,

    CONSTRAINT "texte_titel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "texte_zeit" (
    "id" SERIAL NOT NULL,
    "at" TEXT,
    "eng" TEXT,

    CONSTRAINT "texte_zeit_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ticketnummer" (
    "id" SERIAL NOT NULL,
    "create_date" TIMESTAMP(3),
    "ticketnummer" TEXT,

    CONSTRAINT "ticketnummer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "umsatz_log" (
    "id" SERIAL NOT NULL,
    "datum" TIMESTAMP(3),
    "monat" TEXT,
    "jahr" TEXT,
    "typ" TEXT,
    "umsatz" DOUBLE PRECISION DEFAULT 0,
    "umsatz_hochrechnung" DOUBLE PRECISION DEFAULT 0,
    "umsatz_weniger_gutschrift" DOUBLE PRECISION DEFAULT 0,
    "umsatz_weniger_gutschrift_hochrechnung" DOUBLE PRECISION DEFAULT 0,
    "adwords" DOUBLE PRECISION,
    "adwords_" DOUBLE PRECISION,
    "ver_tage" INTEGER,
    "zu_tage" INTEGER,
    "quelle" TEXT,

    CONSTRAINT "umsatz_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "unsere_daten" (
    "id" SERIAL NOT NULL,
    "firma" TEXT,
    "strasse" TEXT,
    "ort_usw" TEXT,
    "zu_handen" TEXT,
    "tel" TEXT,

    CONSTRAINT "unsere_daten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ups_abholungsarten" (
    "id" SERIAL NOT NULL,
    "show_name" TEXT,
    "service_code_inland" TEXT,
    "service_code_europa" TEXT,
    "service_code_ausland" TEXT,

    CONSTRAINT "ups_abholungsarten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ups_paketnummer" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
    "shipment_identification_number" TEXT,
    "pickup_request_number" TEXT,
    "tracking_number" TEXT,
    "total_charges" TEXT,
    "currency_code" TEXT,
    "art" TEXT,
    "order_id" INTEGER,
    "standort_id" INTEGER,
    "gedruckt" INTEGER DEFAULT 0,
    "gedruckt_am" TIMESTAMP(3),
    "gedruckt_von" TEXT,
    "storniert" INTEGER,
    "storniert_am" TIMESTAMP(3),
    "storniert_von" TEXT,
    "pickup_date" TIMESTAMP(3),

    CONSTRAINT "ups_paketnummer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ursache" (
    "id" SERIAL NOT NULL,
    "bezeichnung" TEXT,
    "typ" TEXT,
    "beschreibung" TEXT,

    CONSTRAINT "ursache_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "usergruppe" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "voller_name" TEXT,

    CONSTRAINT "usergruppe_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "contact_id" INTEGER DEFAULT 0,
    "statistik_spalte_user" TEXT,
    "statistik_spalte" TEXT,
    "anwesend" INTEGER DEFAULT 99,
    "username" TEXT,
    "send_extension" INTEGER DEFAULT 1,
    "extension_to_send" TEXT,
    "usertyp" TEXT DEFAULT 'default',
    "aktiv" INTEGER DEFAULT 1,
    "count_ausgefuellt" INTEGER DEFAULT 0,
    "name_kurz" TEXT,
    "password" TEXT,
    "provision" INTEGER DEFAULT 0,
    "extern" INTEGER DEFAULT 0,
    "send_in_provision_email_abrechnung" INTEGER DEFAULT 0,
    "show_telefon_neukunden_statisik" INTEGER DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "show_leiste_unten" INTEGER DEFAULT 0,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "user_group" INTEGER DEFAULT 0,
    "user_barcode" TEXT,
    "MA_nummer" TEXT,
    "last_login" TIMESTAMP(3),
    "show_in_stat" INTEGER DEFAULT 0,
    "zeiterfassung" INTEGER DEFAULT 0,
    "partner_betreuer" INTEGER DEFAULT 0,
    "statistik_spalte_keyword" TEXT,
    "arbeitgeber_id" INTEGER DEFAULT 1,
    "statistik_spalte_provision" TEXT,
    "statistik_spalte_lead" TEXT,
    "statistik_spalte_firmen" TEXT,
    "positions_id" INTEGER,
    "statistik_spalte_sales" TEXT,
    "statistik_spalte_aufgaben" TEXT,
    "statistik_spalte_eingetroffen" TEXT,
    "send_10h_today" INTEGER,
    "brutto_mindestgehalt" TEXT,
    "maximalrabatt_verkauf" INTEGER DEFAULT 30,
    "kalender_id_waescher" TEXT,
    "statistik_spalte_rohertrag" TEXT,
    "statistik_spalte_campaign" TEXT,
    "not_count_user_statistik" INTEGER,
    "export_to_akoro" INTEGER DEFAULT 1,
    "statistik_spalte_tageszeit_lead" TEXT,
    "statistik_spalte_email" TEXT,
    "show_calls" INTEGER,
    "show_only_own_orders" INTEGER,
    "show_only_own_inquiries" INTEGER,
    "google_account" TEXT,
    "personal_access_token" TEXT,
    "password_hashed" TEXT,
    "mail_notification" INTEGER DEFAULT 0,
    "whatsapp_notification" INTEGER DEFAULT 0,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_details" (
    "details_id" SERIAL NOT NULL,
    "domain" TEXT,
    "ip_adresse" TEXT,
    "mobil" TEXT DEFAULT '0',
    "browser" TEXT,
    "betriebssystem" TEXT,
    "browser_sprache" TEXT,
    "cookie_erlaubt" TEXT DEFAULT '1',
    "javascript_erlaubt" TEXT DEFAULT '1',
    "groesse" TEXT DEFAULT '1',
    "order_id" INTEGER,
    "auftragsnummer" BIGINT,
    "created_at" TIMESTAMP(3),
    "gclid" TEXT,
    "user_created" TEXT,
    "nummern_typ_id" TEXT,

    CONSTRAINT "user_details_pkey" PRIMARY KEY ("details_id")
);

-- CreateTable
CREATE TABLE "user_inquiry_hierarchie" (
    "user_id" INTEGER,
    "sub_user_id" INTEGER
);

-- CreateTable
CREATE TABLE "user_order_hierarchie" (
    "user_id" INTEGER,
    "sub_user_id" INTEGER
);

-- CreateTable
CREATE TABLE "verkaufsprovision_faktor" (
    "id" SERIAL NOT NULL,
    "faktor" DOUBLE PRECISION,

    CONSTRAINT "verkaufsprovision_faktor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verkaufsprovision_prozenfaktor" (
    "id" SERIAL NOT NULL,
    "faktor" DOUBLE PRECISION,
    "prozent" DOUBLE PRECISION,
    "prozent_next" DOUBLE PRECISION,

    CONSTRAINT "verkaufsprovision_prozenfaktor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verkaufsprovision_zeitfaktor" (
    "id" SERIAL NOT NULL,
    "faktor" DOUBLE PRECISION,
    "stunden" DOUBLE PRECISION,
    "tage" DOUBLE PRECISION,
    "tage_next" DOUBLE PRECISION,

    CONSTRAINT "verkaufsprovision_zeitfaktor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "versand_accounts" (
    "id" SERIAL NOT NULL,
    "dienst" TEXT,
    "user" TEXT,
    "pw" TEXT,
    "import_id" TEXT,
    "export_id" TEXT,
    "access_key" TEXT,
    "payment_number" TEXT,
    "host" TEXT,
    "host_auth" TEXT,
    "host_ship" TEXT,
    "host_pickup" TEXT,
    "host_track" TEXT,
    "host_storno" TEXT,
    "host_pickup_storno" TEXT,
    "test_account" INTEGER DEFAULT 0,
    "standort_id" INTEGER NOT NULL,

    CONSTRAINT "versand_accounts_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "waehrung" (
    "id" SERIAL NOT NULL,
    "land" TEXT,
    "kurs" TEXT,
    "bezeichnung" TEXT,
    "datum" TIMESTAMP(3),

    CONSTRAINT "waehrung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "waschobjekt" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "name" TEXT,
    "ist_rechnungsadresse" INTEGER DEFAULT 1,
    "land" TEXT,
    "plz" TEXT,
    "ort" TEXT,
    "straße" TEXT,
    "adresszusatz" TEXT,
    "kanton" TEXT,
    "anfahrt" TEXT,
    "besichtigungstermin_datum" TEXT,
    "besichtigungstermin_vonzeit" TEXT,
    "besichtigungstermin_biszeit" TEXT,
    "verkaeufer" TEXT,
    "anmerkung_besichtigungstermin" TEXT,
    "fassade_ausbesserung_notwendig" INTEGER DEFAULT 0,
    "fassade_sonstige_schaeden" TEXT,
    "gebaeude_hoehe" TEXT,
    "gebaeude_gelenksteiger" INTEGER DEFAULT 0,
    "gebaeude_wiese" INTEGER DEFAULT 0,
    "gebaeude_rolllaeden" INTEGER DEFAULT 0,
    "gebaeude_vorplatz" INTEGER DEFAULT 0,
    "gebaeude_raffstore" INTEGER DEFAULT 0,
    "gebaeude_platz" INTEGER DEFAULT 0,
    "gebaeude_hausumpflasterung" INTEGER DEFAULT 0,
    "gebaeude_stromleitungen" INTEGER DEFAULT 0,
    "gebaeude_werbezwecke" TEXT,
    "gebaeude_flaeche_nord" TEXT,
    "gebaeude_flaeche_ost" TEXT,
    "gebaeude_flaeche_west" TEXT,
    "gebaeude_flaeche_sued" TEXT,
    "gebaeude_einfahrbreite" TEXT,
    "wunschtermin_datum" TEXT,
    "wunschtermin_vonzeit" TEXT,
    "wunschtermin_biszeit" TEXT,
    "kein_wunschtermin" INTEGER DEFAULT 0,
    "termin_nicht_moeglich_datum" TEXT,
    "termin_nicht_moeglich_vonzeit" TEXT,
    "termin_nicht_moeglich_biszeit" TEXT,
    "termin_fassadenreinigung_datum" TEXT,
    "termin_fassadenreinigung_datum_ende" TEXT,
    "termin_fassadenreinigung_vonzeit" TEXT,
    "termin_fassadenreinigung_biszeit" TEXT,
    "termin_fuer_alle" INTEGER DEFAULT 0,
    "wunschtermin_anmerkung" TEXT,
    "gebaeude_anmerkung" TEXT,
    "termin_fassadenreinigung_anmerkung" TEXT,
    "fassadenreinigung_anmerkung" TEXT,
    "fassadenreinigung_laut_angebot" INTEGER DEFAULT 0,
    "fassadenreinigung_zusaetzliche_flaechen" INTEGER DEFAULT 0,
    "waescher" TEXT,
    "lat" TEXT,
    "lng" TEXT,
    "briefkopf_rechnung" TEXT,
    "briefkopf_angebot" TEXT,
    "arbeitszeit_berechnet" TEXT,
    "arbeitszeit_geschaetzt" TEXT,
    "arbeitszeit_ist" TEXT,
    "anzahl_waescher_min" TEXT,
    "freitext_head_angebot" TEXT,
    "freitext_head_rechnung" TEXT,

    CONSTRAINT "waschobjekt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "waschobjekt_fassadeninformationen" (
    "id" SERIAL NOT NULL,
    "waschobjekt_id" INTEGER NOT NULL,
    "fassadeninformation_id" INTEGER NOT NULL,

    CONSTRAINT "waschobjekt_fassadeninformationen_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "waschobjekt_termine" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER,
    "kalender_id" TEXT,
    "termin_id" TEXT,
    "termin_typ" TEXT NOT NULL,
    "created_by" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "deleted" INTEGER NOT NULL DEFAULT 0,
    "von" TEXT,
    "von_time" TEXT,
    "bis" TEXT,
    "bis_time" TEXT,
    "sub_termin_typ" TEXT,
    "username" TEXT,
    "anmerkung" TEXT,

    CONSTRAINT "waschobjekt_termine_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "waschobjekt_waescher" (
    "order_id" INTEGER,
    "user_id" INTEGER,
    "termin_id" INTEGER,
    "google_termin_id" TEXT,
    "created_by" TEXT
);

-- CreateTable
CREATE TABLE "webseiten_standorte" (
    "websites_id" INTEGER NOT NULL,
    "abgabestellen_id" INTEGER NOT NULL,
    "hauptstandort" INTEGER DEFAULT 0,
    "reihenfolge" INTEGER NOT NULL DEFAULT 255
);

-- CreateTable
CREATE TABLE "websites" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "aktiv" INTEGER DEFAULT 1,
    "nummer_id" TEXT,
    "firma_id" INTEGER,
    "haupttelefonnumer" INTEGER,
    "telefonnumer_for_website" TEXT,
    "db_host" TEXT,
    "db_pass" TEXT,
    "db_user" TEXT,
    "db_name" TEXT,
    "profileid" TEXT,
    "seo_anteil_prozent" TEXT,
    "stadt" INTEGER DEFAULT 1,
    "sig_url" TEXT,
    "image_url" TEXT,
    "emailstadt" TEXT,
    "emailbuchhaltungstadt" TEXT,
    "adresse" TEXT,
    "land" TEXT DEFAULT '797',
    "sofortanalyse" TEXT,
    "vielen_dank" TEXT,
    "agb" TEXT,
    "kuerzel_land" TEXT,
    "vorwahl" TEXT,
    "firmen_name" TEXT,
    "hauptstandort_id" TEXT,
    "lat" TEXT,
    "lng" TEXT,
    "nummer_anzeige_website" TEXT,
    "show_in_leads" INTEGER DEFAULT 0,
    "show_in_leads_dat" TIMESTAMP(3),
    "automatisiert_in_google" INTEGER DEFAULT 0,
    "prozentrabatt_verwenden" INTEGER DEFAULT 0,
    "prozentrabatt_wert" INTEGER DEFAULT 0,
    "show_for_partner" INTEGER DEFAULT 1,
    "automatisiert_in_google_pos" DOUBLE PRECISION DEFAULT 0,
    "messtyp" INTEGER DEFAULT 0,
    "text" TEXT,
    "anzeige_manuell_auftrag" INTEGER,

    CONSTRAINT "websites_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "whatsapp_inbox" (
    "id" SERIAL NOT NULL,
    "endpoint_id" INTEGER,
    "message" TEXT NOT NULL,
    "whatsapp_number_id" INTEGER NOT NULL,
    "received" TIMESTAMP(3) NOT NULL,
    "from_number" TEXT NOT NULL,
    "order_id" INTEGER,
    "unread_crm" INTEGER NOT NULL DEFAULT 1,

    CONSTRAINT "whatsapp_inbox_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "whatsapp_numbers" (
    "id" SERIAL NOT NULL,
    "number" TEXT,
    "aktiv" INTEGER NOT NULL DEFAULT 0,
    "description" TEXT,

    CONSTRAINT "whatsapp_numbers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "whatsapp_outbox" (
    "id" SERIAL NOT NULL,
    "endpoint_id" INTEGER NOT NULL,
    "message" TEXT NOT NULL,
    "whatsapp_number_id" INTEGER NOT NULL,
    "order_id" INTEGER,
    "sent" TIMESTAMP(3),

    CONSTRAINT "whatsapp_outbox_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wochentage" (
    "id" SERIAL NOT NULL,
    "wochentag" TEXT,
    "kuerzel" TEXT,
    "tag_texte_id" INTEGER,
    "kuerzel_texte_id" INTEGER,

    CONSTRAINT "wochentage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wp_content" (
    "selector" TEXT,
    "page_id" INTEGER,
    "website_id" INTEGER,
    "content" TEXT
);

-- CreateTable
CREATE TABLE "wp_page" (
    "page_id" INTEGER,
    "name" TEXT,
    "website_id" INTEGER,
    "page_url" TEXT
);

-- CreateTable
CREATE TABLE "wp_selector" (
    "id" SERIAL NOT NULL,
    "name" TEXT,
    "display_name" TEXT,
    "description" TEXT,

    CONSTRAINT "wp_selector_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wp_testimonials" (
    "testimonial_id" INTEGER,
    "website_id" INTEGER,
    "page_id" INTEGER,
    "type" TEXT,
    "video_source" TEXT,
    "image_source" TEXT,
    "second_image_source" TEXT,
    "text" TEXT,
    "customer_text" TEXT,
    "land_id" INTEGER,
    "order" INTEGER
);

-- CreateTable
CREATE TABLE "zeiterfassung" (
    "id" SERIAL NOT NULL,
    "typ" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "feiertag" TEXT,
    "datum" TIMESTAMP(3) NOT NULL,
    "tag" INTEGER,
    "tag_name" TEXT,
    "monat" INTEGER,
    "monat_name" TEXT,
    "jahr" INTEGER,
    "arbeitszeit" TEXT,
    "endezeit" TIMESTAMP(3) NOT NULL,
    "taetigkeit" TEXT NOT NULL,
    "soll_arbeitszeit_help" TEXT NOT NULL DEFAULT '00:00',
    "soll_arbeitszeit" TEXT NOT NULL DEFAULT '00:00',
    "ist_arbeitszeit" TEXT NOT NULL DEFAULT '00:00',
    "pausenzeit" TEXT NOT NULL DEFAULT '00:00',
    "abweichung" TEXT NOT NULL DEFAULT '00:00',
    "abweichung_ohne_uberstunden" TEXT NOT NULL DEFAULT '00:00',
    "abweichung_gesamt" TEXT NOT NULL DEFAULT '00:00',
    "workathome" BOOLEAN NOT NULL DEFAULT false,
    "kuerzel" TEXT,
    "ft" INTEGER,
    "urlaub_verbraucht" TEXT DEFAULT '0',
    "urlaub_rest" TEXT DEFAULT '0',
    "stunden_abzug" TEXT DEFAULT '00:00',
    "anmerkung" TEXT,
    "stunden_gutschrift" TEXT DEFAULT '00:00',
    "automatic_holiday" INTEGER DEFAULT 1,
    "coordinates" TEXT,

    CONSTRAINT "zeiterfassung_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zeiterfassung_kuerzel" (
    "id" SERIAL NOT NULL,
    "kuerzel" TEXT,
    "zeit" TEXT,
    "beschreibung" TEXT,
    "stunden_reduzieren" INTEGER DEFAULT 1,
    "infos" TEXT,

    CONSTRAINT "zeiterfassung_kuerzel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zeiterfassung_save_log" (
    "id" SERIAL NOT NULL,
    "typ" TEXT NOT NULL,
    "user_id" INTEGER NOT NULL,
    "tagid" INTEGER NOT NULL,
    "user" TEXT DEFAULT '0',
    "datum" TIMESTAMP(3) NOT NULL,
    "update_time" TIMESTAMP(3) NOT NULL,
    "arbeitszeit" TEXT,
    "endezeit" TIMESTAMP(3) NOT NULL,
    "taetigkeit" TEXT NOT NULL,
    "soll_arbeitszeit_help" TEXT NOT NULL DEFAULT '00:00',
    "soll_arbeitszeit" TEXT NOT NULL DEFAULT '00:00',
    "ist_arbeitszeit" TEXT NOT NULL DEFAULT '00:00',
    "pausenzeit" TEXT NOT NULL DEFAULT '00:00',
    "abweichung" TEXT NOT NULL DEFAULT '00:00',
    "abweichung_gesamt" TEXT NOT NULL DEFAULT '00:00',
    "workathome" BOOLEAN NOT NULL DEFAULT false,
    "kuerzel" TEXT,
    "ft" INTEGER,
    "feiertag" TEXT,
    "urlaub_verbraucht" TEXT DEFAULT '0',
    "urlaub_rest" TEXT DEFAULT '0',
    "tag" INTEGER,
    "tag_name" TEXT,
    "monat" INTEGER,
    "monat_name" TEXT,
    "jahr" INTEGER,
    "anmerkung" TEXT,

    CONSTRAINT "zeiterfassung_save_log_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zeiterfassung_test" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3),
    "value" TEXT,
    "barcode" TEXT,
    "value1" TEXT,

    CONSTRAINT "zeiterfassung_test_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zeiterfassung_urlaubstage" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "jahr" INTEGER,
    "urlaubstage" DOUBLE PRECISION DEFAULT 25,
    "created_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3),

    CONSTRAINT "zeiterfassung_urlaubstage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zeiterfassung_userdaten" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER,
    "stunden_montag" TEXT DEFAULT '08:15',
    "stunden_dienstag" TEXT DEFAULT '08:15',
    "stunden_mittwoch" TEXT DEFAULT '08:15',
    "stunden_donnerstag" TEXT DEFAULT '08:15',
    "stunden_freitag" TEXT DEFAULT '05:30',
    "stunden_samstag" TEXT DEFAULT '00:00',
    "stunden_sonntag" TEXT DEFAULT '00:00',
    "startdatum" TIMESTAMP(3),
    "created_at" TIMESTAMP(3),
    "ueberstundenpauschale" TEXT DEFAULT '00:00',

    CONSTRAINT "zeiterfassung_userdaten_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zusatz_artikel" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "artikel_id" INTEGER NOT NULL,
    "art" TEXT,
    "typ" TEXT,
    "produkt_id" INTEGER,
    "amount" TEXT,
    "price" TEXT,
    "sum" TEXT,
    "name" TEXT,
    "note" TEXT,
    "vorhanden" INTEGER,
    "gutscheincode_id" INTEGER,
    "rabatt" TEXT,

    CONSTRAINT "zusatz_artikel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "zusatz_artikel_vorlage" (
    "id" SERIAL NOT NULL,
    "order_id" INTEGER NOT NULL,
    "artikel_id" INTEGER NOT NULL,
    "art" TEXT,
    "typ" TEXT,
    "produkt_id" INTEGER,
    "amount" TEXT,
    "price" TEXT,
    "sum" TEXT,
    "name" TEXT,
    "note" TEXT,
    "vorhanden" INTEGER,
    "gutscheincode_id" INTEGER,
    "rabatt" TEXT,

    CONSTRAINT "zusatz_artikel_vorlage_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_leads_emails" (
    "id" SERIAL NOT NULL,
    "datum" TIMESTAMP(3),
    "anzahl" INTEGER DEFAULT 0,

    CONSTRAINT "_leads_emails_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_test_imap" (
    "id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "_test_imap_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "ordnerstruktur" (
    "id" BIGSERIAL NOT NULL,
    "parent_id" BIGINT,
    "name" TEXT NOT NULL,
    "order_index" INTEGER NOT NULL DEFAULT 0,
    "active" BOOLEAN NOT NULL DEFAULT true,
    "default_rechnung" BOOLEAN,
    "default_angebot" BOOLEAN,
    "default_auftragsbestaetigung" BOOLEAN,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by" BIGINT,
    "updated_by" BIGINT,

    CONSTRAINT "ordnerstruktur_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "product_classifications" (
    "id" SERIAL NOT NULL,
    "product_id" BIGINT NOT NULL,
    "classification_type" TEXT,
    "classification_value" TEXT,
    "cross_reference" TEXT,
    "datanorm_import_id" INTEGER,
    "raw_c_record" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "product_classifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pb_calendar_events" (
    "id" SERIAL NOT NULL,
    "title" TEXT NOT NULL,
    "start_at" TIMESTAMP(3) NOT NULL,
    "end_at" TIMESTAMP(3) NOT NULL,
    "duration_min" INTEGER NOT NULL,
    "assignee_id" INTEGER,
    "color" TEXT,
    "company" TEXT,
    "person" TEXT,
    "order_no" TEXT,
    "project_title" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pb_calendar_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pb_resource_bookings" (
    "id" SERIAL NOT NULL,
    "resource_id" INTEGER NOT NULL,
    "project_title" TEXT NOT NULL,
    "start_at" TIMESTAMP(3) NOT NULL,
    "end_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "pb_resource_bookings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pb_resources" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "notes" TEXT,
    "default_project_title" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pb_resources_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pb_special_types" (
    "id" SERIAL NOT NULL,
    "type_key" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "icon" TEXT,
    "color" TEXT,
    "locked" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "pb_special_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pb_specials" (
    "id" SERIAL NOT NULL,
    "person_id" INTEGER NOT NULL,
    "kind_id" INTEGER NOT NULL,
    "start_at" TIMESTAMP(3) NOT NULL,
    "end_at" TIMESTAMP(3) NOT NULL,
    "note" TEXT,

    CONSTRAINT "pb_specials_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "pb_team_assignments" (
    "id" SERIAL NOT NULL,
    "person_id" INTEGER NOT NULL,
    "project_id" INTEGER,
    "project_title" TEXT NOT NULL,
    "title" TEXT,
    "note" TEXT,
    "color" TEXT DEFAULT '#2563eb',
    "order_no" TEXT,
    "start_at" TIMESTAMP(3) NOT NULL,
    "end_at" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "pb_team_assignments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user_phone_extensions" (

);

-- CreateTable
CREATE TABLE "phone_server_logs" (

);

-- CreateTable
CREATE TABLE "angebot_pdf_config" (

);

-- CreateTable
CREATE TABLE "angebot_config" (

);

