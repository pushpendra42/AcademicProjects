library(reshape2)
library(ggplot2)

yaxiscut="Score"
xaxiscut="Task Name"
maincut="NASA-TLX Cutting-Suturing subscales per task"

cutfile1_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session1/Subject01_Cutting1_NASA.csv";
cutfile1_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session2/Subject01_Cutting2_NASA.csv";
cutfile1_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session3/Subject01_Cutting3_NASA.csv";
cutfile1_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session4/Subject01_Cutting4_NASA.csv";
cutfile1_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session5/Subject01_Cutting5_NASA.csv";
suturfile1_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session1/Subject01_Suturing1_NASA.csv";
suturfile1_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session2/Subject01_Suturing2_NASA.csv";
suturfile1_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session3/Subject01_Suturing3_NASA.csv";
suturfile1_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session4/Subject01_Suturing4_NASA.csv";
suturfile1_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject01/subject01/session5/Subject01_Suturing5_NASA.csv";

cutfile2_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session1/subject02_Cutting1_NASA.csv";
cutfile2_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session2/subject02_Cutting2_NASA.csv";
cutfile2_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session3/subject02_Cutting3_NASA.csv";
cutfile2_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session4/subject02_Cutting4_NASA.csv";
cutfile2_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session5/subject02_Cutting5_NASA.csv";
suturfile2_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session1/subject02_Suturing1_NASA.csv";
suturfile2_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session2/subject02_Suturing2_NASA.csv";
suturfile2_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session3/subject02_Suturing3_NASA.csv";
suturfile2_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session4/subject02_Suturing4_NASA.csv";
suturfile2_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject02/subject02/session5/subject02_Suturing5_NASA.csv";

cutfile3_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session1/subject03_Cutting1_NASA.csv";
cutfile3_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session2/subject03_Cutting2_NASA.csv";
cutfile3_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session3/subject03_Cutting3_NASA.csv";
cutfile3_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session4/subject03_Cutting4_NASA.csv";
cutfile3_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session5/subject03_Cutting5_NASA.csv";
suturfile3_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session1/subject03_Suturing1_NASA.csv";
suturfile3_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session2/subject03_Suturing2_NASA.csv";
suturfile3_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session3/subject03_Suturing3_NASA.csv";
suturfile3_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session4/subject03_Suturing4_NASA.csv";
suturfile3_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject03/subject03/session5/subject03_Suturing5_NASA.csv";

cutfile4_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session1/subject04_Cutting1_NASA.csv";
cutfile4_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session2/subject04_Cutting2_NASA.csv";
cutfile4_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session3/subject04_Cutting3_NASA.csv";
cutfile4_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session4/subject04_Cutting4_NASA.csv";
cutfile4_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session5/subject04_Cutting5_NASA.csv";

suturfile4_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session1/subject04_Suturing1_NASA.csv";
suturfile4_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session2/subject04_Suturing2_NASA.csv";
suturfile4_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session3/subject04_Suturing3_NASA.csv";
suturfile4_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session4/subject04_Suturing4_NASA.csv";
suturfile4_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject04/subject04/session5/subject04_Suturing5_NASA.csv";

cutfile5_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject05/subject05/session1/subject05_Cutting1_NASA.csv";
cutfile5_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject05/subject05/session2/subject05_Cutting2_NASA.csv";
cutfile5_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject05/subject05/session3/subject05_Cutting3_NASA.csv";
suturfile5_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject05/subject05/session1/subject05_Suturing1_NASA.csv";
suturfile5_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject05/subject05/session2/subject05_Suturing2_NASA.csv";
suturfile5_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject05/subject05/session3/subject05_Suturing3_NASA.csv";

cutfile6_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject06/subject06/session1/subject06_Cutting1_NASA.csv";
suturfile6_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject06/subject06/session1/subject06_Suturing1_NASA.csv";

cutfile7_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session1/subject07_Cutting1_NASA.csv";
cutfile7_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session2/subject07_Cutting2_NASA.csv";
cutfile7_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session3/subject07_Cutting3_NASA.csv";
cutfile7_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session4/subject07_Cutting4_NASA.csv";
cutfile7_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session5/subject07_Cutting5_NASA.csv";
suturfile7_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session1/subject07_Suturing1_NASA.csv";
suturfile7_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session2/subject07_Suturing2_NASA.csv";
suturfile7_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session3/subject07_Suturing3_NASA.csv";
suturfile7_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session4/subject07_Suturing4_NASA.csv";
suturfile7_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject07/subject07/session5/subject07_Suturing5_NASA.csv";

cutfile8_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session1/subject08_Cutting1_NASA.csv";
cutfile8_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session2/subject08_Cutting2_NASA.csv";
cutfile8_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session3/subject08_Cutting3_NASA.csv";
cutfile8_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session4/subject08_Cutting4_NASA.csv";
cutfile8_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session5/subject08_Cutting5_NASA.csv";
suturfile8_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session1/subject08_Suturing1_NASA.csv";
suturfile8_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session2/subject08_Suturing2_NASA.csv";
suturfile8_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session3/subject08_Suturing3_NASA.csv";
suturfile8_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session4/subject08_Suturing4_NASA.csv";
suturfile8_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject08/subject08/session5/subject08_Suturing5_NASA.csv";

cutfile9_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject09/subject09/session1/subject09_Cutting1_NASA.csv";
cutfile9_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject09/subject09/session2/subject09_Cutting2_NASA.csv";
suturfile9_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject09/subject09/session1/subject09_Suturing1_NASA.csv";
suturfile9_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject09/subject09/session2/subject09_Suturing2_NASA.csv";

cutfile10_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session1/subject10_Cutting1_NASA.csv";
cutfile10_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session2/subject10_Cutting2_NASA.csv";
cutfile10_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session3/subject10_Cutting3_NASA.csv";
cutfile10_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session4/subject10_Cutting4_NASA.csv";
cutfile10_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session5/subject10_Cutting5_NASA.csv";
suturfile10_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session1/subject10_Suturing1_NASA.csv";
suturfile10_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session2/subject10_Suturing2_NASA.csv";
suturfile10_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session3/subject10_Suturing3_NASA.csv";
suturfile10_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session4/subject10_Suturing4_NASA.csv";
suturfile10_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject10/subject10/session5/subject10_Suturing5_NASA.csv";

cutfile11_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session1/subject11_Cutting1_NASA.csv";
cutfile11_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session2/subject11_Cutting2_NASA.csv";
cutfile11_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session3/subject11_Cutting3_NASA.csv";
cutfile11_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session4/subject11_Cutting4_NASA.csv";
cutfile11_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session5/subject11_Cutting5_NASA.csv";
suturfile11_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session1/subject11_Suturing1_NASA.csv";
suturfile11_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session2/subject11_Suturing2_NASA.csv";
suturfile11_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session3/subject11_Suturing3_NASA.csv";
suturfile11_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session4/subject11_Suturing4_NASA.csv";
suturfile11_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject11/subject11/session5/subject11_Suturing5_NASA.csv";

cutfile12_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session1/subject12_Cutting1_NASA.csv";
cutfile12_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session2/subject12_Cutting2_NASA.csv";
cutfile12_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session3/subject12_Cutting3_NASA.csv";
cutfile12_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session4/subject12_Cutting4_NASA.csv";
cutfile12_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session5/subject12_Cutting5_NASA.csv";
suturfile12_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session1/subject12_Suturing1_NASA.csv";
suturfile12_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session2/subject12_Suturing2_NASA.csv";
suturfile12_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session3/subject12_Suturing3_NASA.csv";
suturfile12_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session4/subject12_Suturing4_NASA.csv";
suturfile12_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject12/subject12/session5/subject12_Suturing5_NASA.csv";

cutfile13_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session1/subject13_Cutting1_NASA.csv";
cutfile13_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session2/subject13_Cutting2_NASA.csv";
cutfile13_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session3/subject13_Cutting3_NASA.csv";
cutfile13_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session5/subject13_Cutting5_NASA.csv";
suturfile13_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session1/subject13_Suturing1_NASA.csv";
suturfile13_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session2/subject13_Suturing2_NASA.csv";
suturfile13_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session3/subject13_Suturing3_NASA.csv";
suturfile13_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject13/subject13/session5/subject13_Suturing5_NASA.csv";

cutfile19_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session1/subject19_Cutting1_NASA.csv";
cutfile19_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session2/subject19_Cutting2_NASA.csv";
cutfile19_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session3/subject19_Cutting3_NASA.csv";
cutfile19_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session4/subject19_Cutting4_NASA.csv";
cutfile19_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session5/subject19_Cutting5_NASA.csv";

suturfile19_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session1/subject19_Suturing1_NASA.csv";
suturfile19_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session2/subject19_Suturing2_NASA.csv";
suturfile19_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session3/subject19_Suturing3_NASA.csv";
suturfile19_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session4/subject19_Suturing4_NASA.csv";
suturfile19_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject19/subject19/session5/subject19_Suturing5_NASA.csv";

cutfile20_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject20/subject20/session1/subject20_Cutting1_NASA.csv";
suturfile20_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject20/subject20/session1/subject20_Suturing1_NASA.csv";

cutfile21_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session1/subject21_Cutting1_NASA.csv";
cutfile21_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session2/subject21_Cutting2_NASA.csv";
cutfile21_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session3/subject21_Cutting3_NASA.csv";
cutfile21_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session4/subject21_Cutting4_NASA.csv";
cutfile21_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session5/subject21_Cutting5_NASA.csv";
suturfile21_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session1/subject21_Suturing1_NASA.csv";
suturfile21_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session2/subject21_Suturing2_NASA.csv";
suturfile21_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session3/subject21_Suturing3_NASA.csv";
suturfile21_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session4/subject21_Suturing4_NASA.csv";
suturfile21_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject21/subject21/session5/subject21_Suturing5_NASA.csv";

cutfile22_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session1/subject22_Cutting1_NASA.csv";
cutfile22_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session2/subject22_Cutting2_NASA.csv";
cutfile22_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session3/subject22_Cutting3_NASA.csv";
cutfile22_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session4/subject22_Cutting4_NASA.csv";
cutfile22_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session5/subject22_Cutting5_NASA.csv";
suturfile22_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session1/subject22_Suturing1_NASA.csv";
suturfile22_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session2/subject22_Suturing2_NASA.csv";
suturfile22_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session3/subject22_Suturing3_NASA.csv";
suturfile22_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session4/subject22_Suturing4_NASA.csv";
suturfile22_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject22/subject22/session5/subject22_Suturing5_NASA.csv";

cutfile23_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session1/subject23_Cutting1_NASA.csv";
cutfile23_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session2/subject23_Cutting2_NASA.csv";
cutfile23_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session3/subject23_Cutting3_NASA.csv";
cutfile23_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session4/subject23_Cutting4_NASA.csv";
cutfile23_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session5/subject23_Cutting5_NASA.csv";
suturfile23_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session1/subject23_Suturing1_NASA.csv";
suturfile23_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session2/subject23_Suturing2_NASA.csv";
suturfile23_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session3/subject23_Suturing3_NASA.csv";
suturfile23_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session4/subject23_Suturing4_NASA.csv";
suturfile23_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject23/subject23/session5/subject23_Suturing5_NASA.csv";

cutfile24_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session1/subject24_Cutting1_NASA.csv";
cutfile24_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session2/subject24_Cutting2_NASA.csv";
cutfile24_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session3/subject24_Cutting3_NASA.csv";
cutfile24_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session4/subject24_Cutting4_NASA.csv";
cutfile24_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session5/subject24_Cutting5_NASA.csv";

suturfile24_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session1/subject24_Suturing1_NASA.csv";
suturfile24_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session2/subject24_Suturing2_NASA.csv";
suturfile24_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session3/subject24_Suturing3_NASA.csv";
suturfile24_4="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session4/subject24_Suturing4_NASA.csv";
suturfile24_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject24/subject24/session5/subject24_Suturing5_NASA.csv";

cutfile25_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject25/subject25/session1/subject25_Cutting1_NASA.csv";
cutfile25_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject25/subject25/session2/subject25_Cutting2_NASA.csv";
suturfile25_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject25/subject25/session1/subject25_Suturing1_NASA.csv";
suturfile25_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject25/subject25/session2/subject25_Suturing2_NASA.csv";

cutfile26_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session1/subject26_Cutting1_NASA.csv";
cutfile26_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session2/subject26_Cutting2_NASA.csv";
cutfile26_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session3/subject26_Cutting3_NASA.csv";
cutfile26_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session5/subject26_Cutting5_NASA.csv";
suturfile26_1="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session1/subject26_Suturing1_NASA.csv";
suturfile26_2="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session2/subject26_Suturing2_NASA.csv";
suturfile26_3="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session3/subject26_Suturing3_NASA.csv";
suturfile26_5="D:/CourseWork/Statstical/Project/osfstorage-archive/Methodist microsurgery with output/subject26/subject26/session5/subject26_Suturing5_NASA.csv";

sub1session1_1cut<-read.csv(file=cutfile1_1)
sub1session1_2cut<-read.csv(file=cutfile1_2)
sub1session1_3cut<-read.csv(file=cutfile1_3)
sub1session1_4cut<-read.csv(file=cutfile1_4)
sub1session1_5cut<-read.csv(file=cutfile1_5)
sub1session1_1Sutur<-read.csv(file=suturfile1_1)
sub1session1_2Sutur<-read.csv(file=suturfile1_2)
sub1session1_3Sutur<-read.csv(file=suturfile1_3)
sub1session1_4Sutur<-read.csv(file=suturfile1_4)
sub1session1_5Sutur<-read.csv(file=suturfile1_5)

sub1session2_1cut<-read.csv(file=cutfile2_1)
sub1session2_2cut<-read.csv(file=cutfile2_2)
sub1session2_3cut<-read.csv(file=cutfile2_3)
sub1session2_4cut<-read.csv(file=cutfile2_4)
sub1session2_5cut<-read.csv(file=cutfile2_5)
sub1session2_1Sutur<-read.csv(file=suturfile2_1)
sub1session2_2Sutur<-read.csv(file=suturfile2_2)
sub1session2_3Sutur<-read.csv(file=suturfile2_3)
sub1session2_4Sutur<-read.csv(file=suturfile2_4)
sub1session2_5Sutur<-read.csv(file=suturfile2_5)

sub1session3_1cut<-read.csv(file=cutfile3_1)
sub1session3_2cut<-read.csv(file=cutfile3_2)
sub1session3_3cut<-read.csv(file=cutfile3_3)
sub1session3_4cut<-read.csv(file=cutfile3_4)
sub1session3_5cut<-read.csv(file=cutfile3_5)
sub1session3_1Sutur<-read.csv(file=suturfile3_1)
sub1session3_2Sutur<-read.csv(file=suturfile3_2)
sub1session3_3Sutur<-read.csv(file=suturfile3_3)
sub1session3_4Sutur<-read.csv(file=suturfile3_4)
sub1session3_5Sutur<-read.csv(file=suturfile3_5)

sub1session4_1cut<-read.csv(file=cutfile4_1)
sub1session4_2cut<-read.csv(file=cutfile4_2)
sub1session4_3cut<-read.csv(file=cutfile4_3)
sub1session4_4cut<-read.csv(file=cutfile4_4)
sub1session4_5cut<-read.csv(file=cutfile4_5)
sub1session4_1Sutur<-read.csv(file=suturfile4_1)
sub1session4_2Sutur<-read.csv(file=suturfile4_2)
sub1session4_3Sutur<-read.csv(file=suturfile4_3)
sub1session4_4Sutur<-read.csv(file=suturfile4_4)
sub1session4_5Sutur<-read.csv(file=suturfile4_5)

sub1session5_1cut<-read.csv(file=cutfile5_1)
sub1session5_2cut<-read.csv(file=cutfile5_2)
sub1session5_3cut<-read.csv(file=cutfile5_3)
sub1session5_1Sutur<-read.csv(file=suturfile5_1)
sub1session5_2Sutur<-read.csv(file=suturfile5_2)
sub1session5_3Sutur<-read.csv(file=suturfile5_3)

sub1session6_1cut<-read.csv(file=cutfile6_1)
sub1session6_1Sutur<-read.csv(file=suturfile6_1)

sub1session7_1cut<-read.csv(file=cutfile7_1)
sub1session7_2cut<-read.csv(file=cutfile7_2)
sub1session7_3cut<-read.csv(file=cutfile7_3)
sub1session7_4cut<-read.csv(file=cutfile7_4)
sub1session7_5cut<-read.csv(file=cutfile7_5)
sub1session7_1Sutur<-read.csv(file=suturfile7_1)
sub1session7_2Sutur<-read.csv(file=suturfile7_2)
sub1session7_3Sutur<-read.csv(file=suturfile7_3)
sub1session7_4Sutur<-read.csv(file=suturfile7_4)
sub1session7_5Sutur<-read.csv(file=suturfile7_5)

sub1session8_1cut<-read.csv(file=cutfile8_1)
sub1session8_2cut<-read.csv(file=cutfile8_2)
sub1session8_3cut<-read.csv(file=cutfile8_3)
sub1session8_4cut<-read.csv(file=cutfile8_4)
sub1session8_5cut<-read.csv(file=cutfile8_5)
sub1session8_1Sutur<-read.csv(file=suturfile8_1)
sub1session8_2Sutur<-read.csv(file=suturfile8_2)
sub1session8_3Sutur<-read.csv(file=suturfile8_3)
sub1session8_4Sutur<-read.csv(file=suturfile8_4)
sub1session8_5Sutur<-read.csv(file=suturfile8_5)

sub1session9_1cut<-read.csv(file=cutfile9_1)
sub1session9_2cut<-read.csv(file=cutfile9_2)
sub1session9_1Sutur<-read.csv(file=suturfile9_1)
sub1session9_2Sutur<-read.csv(file=suturfile9_2)

sub1session10_1cut<-read.csv(file=cutfile10_1)
sub1session10_2cut<-read.csv(file=cutfile10_2)
sub1session10_3cut<-read.csv(file=cutfile10_3)
sub1session10_4cut<-read.csv(file=cutfile10_4)
sub1session10_5cut<-read.csv(file=cutfile10_5)
sub1session10_1Sutur<-read.csv(file=suturfile10_1)
sub1session10_2Sutur<-read.csv(file=suturfile10_2)
sub1session10_3Sutur<-read.csv(file=suturfile10_3)
sub1session10_4Sutur<-read.csv(file=suturfile10_4)
sub1session10_5Sutur<-read.csv(file=suturfile10_5)

sub1session11_1cut<-read.csv(file=cutfile11_1)
sub1session11_2cut<-read.csv(file=cutfile11_2)
sub1session11_3cut<-read.csv(file=cutfile11_3)
sub1session11_4cut<-read.csv(file=cutfile11_4)
sub1session11_5cut<-read.csv(file=cutfile11_5)
sub1session11_1Sutur<-read.csv(file=suturfile11_1)
sub1session11_2Sutur<-read.csv(file=suturfile11_2)
sub1session11_3Sutur<-read.csv(file=suturfile11_3)
sub1session11_4Sutur<-read.csv(file=suturfile11_4)
sub1session11_5Sutur<-read.csv(file=suturfile11_5)

sub1session12_1cut<-read.csv(file=cutfile12_1)
sub1session12_2cut<-read.csv(file=cutfile12_2)
sub1session12_3cut<-read.csv(file=cutfile12_3)
sub1session12_4cut<-read.csv(file=cutfile12_4)
sub1session12_5cut<-read.csv(file=cutfile12_5)
sub1session12_1Sutur<-read.csv(file=suturfile12_1)
sub1session12_2Sutur<-read.csv(file=suturfile12_2)
sub1session12_3Sutur<-read.csv(file=suturfile12_3)
sub1session12_4Sutur<-read.csv(file=suturfile12_4)
sub1session12_5Sutur<-read.csv(file=suturfile12_5)

sub1session13_1cut<-read.csv(file=cutfile13_1)
sub1session13_2cut<-read.csv(file=cutfile13_2)
sub1session13_3cut<-read.csv(file=cutfile13_3)
sub1session13_5cut<-read.csv(file=cutfile13_5)
sub1session13_1Sutur<-read.csv(file=suturfile13_1)
sub1session13_2Sutur<-read.csv(file=suturfile13_2)
sub1session13_3Sutur<-read.csv(file=suturfile13_3)
sub1session13_5Sutur<-read.csv(file=suturfile13_5)

sub1session19_1cut<-read.csv(file=cutfile19_1)
sub1session19_2cut<-read.csv(file=cutfile19_2)
sub1session19_3cut<-read.csv(file=cutfile19_3)
sub1session19_4cut<-read.csv(file=cutfile19_4)
sub1session19_5cut<-read.csv(file=cutfile19_5)
sub1session19_1Sutur<-read.csv(file=suturfile19_1)
sub1session19_2Sutur<-read.csv(file=suturfile19_2)
sub1session19_3Sutur<-read.csv(file=suturfile19_3)
sub1session19_4Sutur<-read.csv(file=suturfile19_4)
sub1session19_5Sutur<-read.csv(file=suturfile19_5)

sub1session20_1cut<-read.csv(file=cutfile20_1)
sub1session20_1Sutur<-read.csv(file=suturfile20_1)

sub1session21_1cut<-read.csv(file=cutfile21_1)
sub1session21_2cut<-read.csv(file=cutfile21_2)
sub1session21_3cut<-read.csv(file=cutfile21_3)
sub1session21_4cut<-read.csv(file=cutfile21_4)
sub1session21_5cut<-read.csv(file=cutfile21_5)
sub1session21_1Sutur<-read.csv(file=suturfile21_1)
sub1session21_2Sutur<-read.csv(file=suturfile21_2)
sub1session21_3Sutur<-read.csv(file=suturfile21_3)
sub1session21_4Sutur<-read.csv(file=suturfile21_4)
sub1session21_5Sutur<-read.csv(file=suturfile21_5)

sub1session22_1cut<-read.csv(file=cutfile22_1)
sub1session22_2cut<-read.csv(file=cutfile22_2)
sub1session22_3cut<-read.csv(file=cutfile22_3)
sub1session22_4cut<-read.csv(file=cutfile22_4)
sub1session22_5cut<-read.csv(file=cutfile22_5)
sub1session22_1Sutur<-read.csv(file=suturfile22_1)
sub1session22_2Sutur<-read.csv(file=suturfile22_2)
sub1session22_3Sutur<-read.csv(file=suturfile22_3)
sub1session22_4Sutur<-read.csv(file=suturfile22_4)
sub1session22_5Sutur<-read.csv(file=suturfile22_5)

sub1session23_1cut<-read.csv(file=cutfile23_1)
sub1session23_2cut<-read.csv(file=cutfile23_2)
sub1session23_3cut<-read.csv(file=cutfile23_3)
sub1session23_4cut<-read.csv(file=cutfile23_4)
sub1session23_1Sutur<-read.csv(file=suturfile23_1)
sub1session23_2Sutur<-read.csv(file=suturfile23_2)
sub1session23_3Sutur<-read.csv(file=suturfile23_3)
sub1session23_4Sutur<-read.csv(file=suturfile23_4)

sub1session24_1cut<-read.csv(file=cutfile24_1)
sub1session24_2cut<-read.csv(file=cutfile24_2)
sub1session24_3cut<-read.csv(file=cutfile24_3)
sub1session24_4cut<-read.csv(file=cutfile24_4)
sub1session24_5cut<-read.csv(file=cutfile24_5)
sub1session24_1Sutur<-read.csv(file=suturfile24_1)
sub1session24_2Sutur<-read.csv(file=suturfile24_2)
sub1session24_3Sutur<-read.csv(file=suturfile24_3)
sub1session24_4Sutur<-read.csv(file=suturfile24_4)
sub1session24_5Sutur<-read.csv(file=suturfile24_5)

sub1session25_1cut<-read.csv(file=cutfile25_1)
sub1session25_2cut<-read.csv(file=cutfile25_2)
sub1session25_1Sutur<-read.csv(file=suturfile25_1)
sub1session25_2Sutur<-read.csv(file=suturfile25_2)

sub1session26_1cut<-read.csv(file=cutfile26_1)
sub1session26_2cut<-read.csv(file=cutfile26_2)
sub1session26_3cut<-read.csv(file=cutfile26_3)
sub1session26_5cut<-read.csv(file=cutfile26_5)
sub1session26_1Sutur<-read.csv(file=suturfile26_1)
sub1session26_2Sutur<-read.csv(file=suturfile26_2)
sub1session26_3Sutur<-read.csv(file=suturfile26_3)
sub1session26_5Sutur<-read.csv(file=suturfile26_5)

finaldata=NULL

finaldata=sub1session1_1cut
finaldata$Subject="Subject1"
finaldata$Cutting2=sub1session1_2cut$Cutting2
finaldata$Cutting3=sub1session1_3cut$Cutting3
finaldata$Cutting4=sub1session1_4cut$Cutting4
finaldata$Cutting5=sub1session1_5cut$Cutting5
finaldata$Sutur1 =sub1session1_1Sutur$Suturing1
finaldata$Sutur2=sub1session1_2Sutur$Suturing2
finaldata$Sutur3=sub1session1_3Sutur$Suturing3
finaldata$Sutur4=sub1session1_4Sutur$Suturing4
finaldata$Sutur5=sub1session1_5Sutur$Suturing5

df2=data.frame()
df2=sub1session2_1cut
df2$Subject="Subject2"
df2$Cutting2=sub1session2_2cut$Cutting2
df2$Cutting3=sub1session2_3cut$Cutting3
df2$Cutting4=sub1session2_4cut$Cutting4
df2$Cutting5=sub1session2_5cut$Cutting5
df2$Sutur1 =sub1session2_1Sutur$Suturing1
df2$Sutur2=sub1session2_2Sutur$Suturing2
df2$Sutur3=sub1session2_3Sutur$Suturing3
df2$Sutur4=sub1session2_4Sutur$Suturing4
df2$Sutur5=sub1session2_5Sutur$Suturing5
finaldata=rbind(finaldata,df2)

df3=data.frame()
df3=sub1session3_1cut
df3$Subject="Subject3"
df3$Cutting2=sub1session3_2cut$Cutting2
df3$Cutting3=sub1session3_3cut$Cutting3
df3$Cutting4=sub1session3_4cut$Cutting4
df3$Cutting5=sub1session3_5cut$Cutting5
df3$Sutur1 =sub1session3_1Sutur$Suturing1
df3$Sutur2=sub1session3_2Sutur$Suturing2
df3$Sutur3=sub1session3_3Sutur$Suturing3
df3$Sutur4=sub1session3_4Sutur$Suturing4
df3$Sutur5=sub1session3_5Sutur$Suturing5
finaldata=rbind(finaldata,df3)

df4=data.frame()
df4=sub1session4_1cut
df4$Subject="Subject4"
df4$Cutting2=sub1session4_2cut$Cutting2
df4$Cutting3=sub1session4_3cut$Cutting3
df4$Cutting4=sub1session4_4cut$Cutting4
df4$Cutting5=sub1session4_5cut$Cutting5
df4$Sutur1 =sub1session3_1Sutur$Suturing1
df4$Sutur2=sub1session4_2Sutur$Suturing2
df4$Sutur3=sub1session4_3Sutur$Suturing3
df4$Sutur4=sub1session4_4Sutur$Suturing4
df4$Sutur5=sub1session4_5Sutur$Suturing5
finaldata=rbind(finaldata,df4)

df5=data.frame()
df5=sub1session5_1cut
df5$Subject="Subject5"
df5$Cutting2=sub1session5_2cut$Cutting2
df5$Cutting3=sub1session5_3cut$Cutting3
df5$Cutting4=""
df5$Cutting5=""
df5$Sutur1 =sub1session5_1Sutur$Suturing1
df5$Sutur2=sub1session5_2Sutur$Suturing2
df5$Sutur3=sub1session5_3Sutur$Suturing3
df5$Sutur4=""
df5$Sutur5=""
finaldata=rbind(finaldata,df5)


df6=data.frame()
df6=sub1session6_1cut
df6$Subject="Subject6"
df6$Cutting2=""
df6$Cutting3=""
df6$Cutting4=""
df6$Cutting5=""
df6$Sutur1 =sub1session6_1Sutur$Suturing1
df6$Sutur2=""
df6$Sutur3=""
df6$Sutur4=""
df6$Sutur5=""
finaldata=rbind(finaldata,df6)

df7=data.frame()
df7=sub1session7_1cut
df7$Subject="Subject7"
df7$Cutting2=sub1session7_2cut$Cutting2
df7$Cutting3=sub1session7_3cut$Cutting3
df7$Cutting4=sub1session7_4cut$Cutting4
df7$Cutting5=sub1session7_5cut$Cutting5
df7$Sutur1 =sub1session7_1Sutur$Suturing1
df7$Sutur2=sub1session7_2Sutur$Suturing2
df7$Sutur3=sub1session7_3Sutur$Suturing3
df7$Sutur4=sub1session7_4Sutur$Suturing4
df7$Sutur5=sub1session7_5Sutur$Suturing5
finaldata=rbind(finaldata,df7)

df8=data.frame()
df8=sub1session8_1cut
df8$Subject="Subject8"
df8$Cutting2=sub1session8_2cut$Cutting2
df8$Cutting3=sub1session8_3cut$Cutting3
df8$Cutting4=sub1session8_4cut$Cutting4
df8$Cutting5=sub1session8_5cut$Cutting5
df8$Sutur1 =sub1session8_1Sutur$Suturing1
df8$Sutur2=sub1session8_2Sutur$Suturing2
df8$Sutur3=sub1session8_3Sutur$Suturing3
df8$Sutur4=sub1session8_4Sutur$Suturing4
df8$Sutur5=sub1session8_5Sutur$Suturing5
finaldata=rbind(finaldata,df8)

df9=data.frame()
df9=sub1session9_1cut
df9$Subject="Subject9"
df9$Cutting2=sub1session9_2cut$Cutting2
df9$Cutting3=""
df9$Cutting4=""
df9$Cutting5=""
df9$Sutur1 =sub1session9_1Sutur$Suturing1
df9$Sutur2=sub1session9_2Sutur$Suturing2
df9$Sutur3=""
df9$Sutur4=""
df9$Sutur5=""
finaldata=rbind(finaldata,df9)

df10=data.frame()
df10=sub1session10_1cut
df10$Subject="Subject10"
df10$Cutting2=sub1session10_2cut$Cutting2
df10$Cutting3=sub1session10_3cut$Cutting3
df10$Cutting4=sub1session10_4cut$Cutting4
df10$Cutting5=sub1session10_5cut$Cutting5
df10$Sutur1 =sub1session10_1Sutur$Suturing1
df10$Sutur2=sub1session10_2Sutur$Suturing2
df10$Sutur3=sub1session10_3Sutur$Suturing3
df10$Sutur4=sub1session10_4Sutur$Suturing4
df10$Sutur5=sub1session10_5Sutur$Suturing5
finaldata=rbind(finaldata,df10)

df11=data.frame()
df11=sub1session11_1cut
df11$Subject="Subject11"
df11$Cutting2=sub1session11_2cut$Cutting2
df11$Cutting3=sub1session11_3cut$Cutting3
df11$Cutting4=sub1session11_4cut$Cutting4
df11$Cutting5=sub1session11_5cut$Cutting5
df11$Sutur1 =sub1session11_1Sutur$Suturing1
df11$Sutur2=sub1session11_2Sutur$Suturing2
df11$Sutur3=sub1session11_3Sutur$Suturing3
df11$Sutur4=sub1session11_4Sutur$Suturing4
df11$Sutur5=sub1session11_5Sutur$Suturing5
finaldata=rbind(finaldata,df11)

df12=data.frame()
df12=sub1session12_1cut
df12$Subject="Subject12"
df12$Cutting2=sub1session12_2cut$Cutting2
df12$Cutting3=sub1session12_3cut$Cutting3
df12$Cutting4=sub1session12_4cut$Cutting4
df12$Cutting5=sub1session12_5cut$Cutting5
df12$Sutur1 =sub1session3_1Sutur$Suturing1
df12$Sutur2=sub1session12_2Sutur$Suturing2
df12$Sutur3=sub1session12_3Sutur$Suturing3
df12$Sutur4=sub1session12_4Sutur$Suturing4
df12$Sutur5=sub1session12_5Sutur$Suturing5
finaldata=rbind(finaldata,df12)

df13=data.frame()
df13=sub1session13_1cut
df13$Subject="Subject13"
df13$Cutting2=sub1session13_2cut$Cutting2
df13$Cutting3=sub1session13_3cut$Cutting3
df13$Cutting4=""
df13$Cutting5=sub1session13_5cut$Cutting5
df13$Sutur1 =sub1session13_1Sutur$Suturing1
df13$Sutur2=sub1session13_2Sutur$Suturing2
df13$Sutur3=sub1session13_3Sutur$Suturing3
df13$Sutur4=""
df13$Sutur5=sub1session13_5Sutur$Suturing5
finaldata=rbind(finaldata,df13)

df19=data.frame()
df19=sub1session19_1cut
df19$Subject="Subject19"
df19$Cutting2=sub1session19_2cut$Cutting2
df19$Cutting3=sub1session19_3cut$Cutting3
df19$Cutting4=sub1session19_4cut$Cutting4
df19$Cutting5=sub1session19_5cut$Cutting5
df19$Sutur1 =sub1session19_1Sutur$Suturing1
df19$Sutur2=sub1session19_2Sutur$Suturing2
df19$Sutur3=sub1session19_3Sutur$Suturing3
df19$Sutur4=sub1session19_4Sutur$Suturing4
df19$Sutur5=sub1session19_5Sutur$Suturing5
finaldata=rbind(finaldata,df19)

df20=data.frame()
df20=sub1session20_1cut
df20$Subject="Subject20"
df20$Cutting2=""
df20$Cutting3=""
df20$Cutting4=""
df20$Cutting5=""
df20$Sutur1=sub1session20_1Sutur$Suturing1
df20$Sutur2=""
df20$Sutur3=""
df20$Sutur4=""
df20$Sutur5=""
finaldata=rbind(finaldata,df20)

df21=data.frame()
df21=sub1session21_1cut
df21$Subject="Subject21"
df21$Cutting2=sub1session21_2cut$Cutting2
df21$Cutting3=sub1session21_3cut$Cutting3
df21$Cutting4=sub1session21_4cut$Cutting4
df21$Cutting5=sub1session21_5cut$Cutting5
df21$Sutur1 =sub1session21_1Sutur$Suturing1
df21$Sutur2=sub1session21_2Sutur$Suturing2
df21$Sutur3=sub1session21_3Sutur$Suturing3
df21$Sutur4=sub1session21_4Sutur$Suturing4
df21$Sutur5=sub1session21_5Sutur$Suturing5
finaldata=rbind(finaldata,df21)

df22=data.frame()
df22=sub1session22_1cut
df22$Subject="Subject22"
df22$Cutting2=sub1session22_2cut$Cutting2
df22$Cutting3=sub1session22_3cut$Cutting3
df22$Cutting4=sub1session22_4cut$Cutting4
df22$Cutting5=sub1session22_5cut$Cutting5
df22$Sutur1 =sub1session22_1Sutur$Suturing1
df22$Sutur2=sub1session22_2Sutur$Suturing2
df22$Sutur3=sub1session22_3Sutur$Suturing3
df22$Sutur4=sub1session22_4Sutur$Suturing4
df22$Sutur5=sub1session22_5Sutur$Suturing5
finaldata=rbind(finaldata,df22)

df23=data.frame()
df23=sub1session23_1cut
df23$Subject="Subject23"
df23$Cutting2=sub1session23_2cut$Cutting2
df23$Cutting3=sub1session23_3cut$Cutting3
df23$Cutting4=sub1session23_4cut$Cutting4
df23$Cutting5=""
df23$Sutur1 =sub1session23_1Sutur$Suturing1
df23$Sutur2=sub1session23_2Sutur$Suturing2
df23$Sutur3=sub1session23_3Sutur$Suturing3
df23$Sutur4=sub1session23_4Sutur$Suturing4
df23$Sutur5=""
finaldata=rbind(finaldata,df23)

df24=data.frame()
df24=sub1session24_1cut
df24$Subject="Subject24"
df24$Cutting2=sub1session24_2cut$Cutting2
df24$Cutting3=sub1session24_3cut$Cutting3
df24$Cutting4=sub1session24_4cut$Cutting4
df24$Cutting5=sub1session24_5cut$Cutting5
df24$Sutur1 =sub1session24_1Sutur$Suturing1
df24$Sutur2=sub1session24_2Sutur$Suturing2
df24$Sutur3=sub1session24_3Sutur$Suturing3
df24$Sutur4=sub1session24_4Sutur$Suturing4
df24$Sutur5=sub1session24_5Sutur$Suturing5
finaldata=rbind(finaldata,df24)

df25=data.frame()
df25=sub1session25_1cut
df25$Subject="Subject25"
df25$Cutting2=sub1session25_2cut$Cutting2
df25$Cutting3=""
df25$Cutting4=""
df25$Cutting5=""
df25$Sutur1 =sub1session25_1Sutur$Suturing1
df25$Sutur2=sub1session25_2Sutur$Suturing2
df25$Sutur3=""
df25$Sutur4=""
df25$Sutur5=""
finaldata=rbind(finaldata,df25)

df26=data.frame()
df26=sub1session26_1cut
df26$Subject="Subject26"
df26$Cutting2=sub1session26_2cut$Cutting2
df26$Cutting3=sub1session26_3cut$Cutting3
df26$Cutting4=""
df26$Cutting5=sub1session26_5cut$Cutting5
df26$Sutur1 =sub1session26_1Sutur$Suturing1
df26$Sutur2=sub1session26_2Sutur$Suturing2
df26$Sutur3=sub1session26_3Sutur$Suturing3
df26$Sutur4=""
df26$Sutur5=sub1session26_5Sutur$Suturing5

finaldata=rbind(finaldata,df26)
write.csv(finaldata, "d:/finaldata.csv")
