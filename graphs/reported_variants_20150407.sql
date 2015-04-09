create table reported_variants_20150407 (
sampleId character varying,
requestId character varying,
snvgene character varying,
mutation_aa character varying,
percentage character varying,
cfdna_perc character varying,
cancertype character varying,
colldate character varying,
finalrepdate character varying,
requesttype character varying
);

copy reported_variants_20150407 from '/home/rlopez/All_SNV_040715_edit.csv' DELIMITER ',' CSV;

