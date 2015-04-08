# connect to the database and create a graph
ghdbConnect <- function(drv) {
    require(RPostgreSQL)
    dbConnect(drv, host='ghpsjcUB03', dbname="ghdb",
                user='admin', password='PASSWORD')
}

require(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- ghdbConnect(drv)
#rs <- dbSendQuery(con, "select pos,read_f_a+read_r_a+read_overlap_a*2+read_f_c+read_r_c+read_overlap_c*2+read_f_g+read_r_g+read_overlap_g*2+read_f_t+read_r_t+read_overlap_t*2 from ghm_snp where run_sample_id='A0550101_1';")
rs <- dbSendQuery(con, "select to_number(replace(replace(s.chrom,'X','23'),'Y','24'),'999999999999'),s.pos,read_f_a+read_r_a+read_overlap_a*2+read_f_c+read_r_c+read_overlap_c*2+read_f_g+read_r_g+read_overlap_g*2+read_f_t+read_r_t+read_overlap_t*2 from ghm_snp s, (select chrom,pos from gh_annotation_ss4 where aa_change!='' group by chrom,pos) a where run_sample_id='A0550001_1' and s.chrom=a.chrom and a.pos=s.pos order by s.chrom,s.pos limit 1000000;")
# 10   : 27023032
# 100  : 27023122
# 1000 : 27056259
# 10000: 123239433
dbtable <- fetch(rs, n=-1)
#x <- dbtable[,2]
x <- 1:nrow(dbtable)
#y <- log10(dbtable[,3])
y <- dbtable[,3]

#pdf("/media/warp2/pipeline/SSNV4_RENE/A0550101_1_200Bins.pdf")
png("/media/warp2/pipeline/SSNV4_RENE/A0550101_1_200Bins_exons.png", width=1200)

# plot by chrom/pos and read counts (log10)
plot(x, y, ylim=c(0,35000), pch=".") # plots the results
abline(h=500, col="red")

# frequency or density plots
#hist(y, breaks=200, main="Frequence of read counts")

dev.off()
dbDisconnect(con)

