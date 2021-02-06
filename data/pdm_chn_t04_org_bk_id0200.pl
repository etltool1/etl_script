#/*************************************************************************************************/
# 鑴氭湰鍚�        : rps_chn_dtl_txn_c_bzt0200.pl
# 鑴氭湰涓枃鍚�    锛氭姤璐﹂�氭槑缁嗚〃
# 鍏徃鍚嶇О      : 涓婃捣娉撴櫤
# 璁捐浜哄憳      :鏉ㄦ瘏
# 寮�鍙戜汉鍛�      : trans
# 绋嬪簭璇存槑      :
#/***************************************************************************************************/
#!/usr/bin/perl
#/***************************************************************************************************/
#/*BTEQ script in Perl, generate by Teradata Minerva 2007(by David Qi, DQ185000@TERADATA.COM)       */
#/*Brilliance stems from wisdoms.                                                                   */
#/*************Head Section**************************************************************************/
#/*Script Use: Periodically load data to                                                            */
#/*Create Date:                                                                                     */
#/*SDM Developed By:                                                                                */
#/*SDM Developed Date:                                                                              */
#/*SDM Checked By:                                                                                  */
#/*SDM Checked Date:                                                                                */
#/*Script Developed By:                                                                             */
#/*Script Checked By:                                                                               */
#/*Source table 1:ECTBZT                                                                            */
#/*Source table 2:T03_AGMT_RELA_H                                                                   */
#/*Source table 3:T05_GAPS_VCH_FINANCE                                                              */
#/*Source table 4:t03_card                                                                          */
#/*Target Table:  DTL_TXN_C_BZT                                                                     */
#/*Job Type: ETL-PDM                                                                                */
#/*ETL Frequency:                                                                                   */
#/*ETL Policy:                                                                                      */
#/*Revision History: Revision Level          Date Revised          Comments          Initiated By   */

use strict;
use Encode;
my $AUTO_HOME = $ENV{"AUTO_HOME"};
my $BASEPM_PATH = $ENV{'AUTO_BASEPM_PATH'} || "${AUTO_HOME}/bin";
$BASEPM_PATH = '.' unless(-d $BASEPM_PATH);
require "${BASEPM_PATH}/etlbase.pm";

#========================================================================
#   here, difined some vars to compitible with Minerva embeded vars
#========================================================================
my $MINDATE   = $BASE::MINDATE;
my $MAXDATE   = $BASE::MAXDATE;
my $NULLDATE  = $BASE::NULLDATE;
my $ILLDATE   = $BASE::ILLDATE;
my $TX_DATE   = $BASE::TX_DATE;
my $JOB_NAME  = $BASE::JOB_NAME;

my $RPSDATADB = $ENV{"AUTO_CHN_RPSDATADB"};

my $SCRIPT= "pdm_chn_t04_org_bk_id0200.pl";
#========================================================================

#濉啓涓氬姟閫昏緫SQL璇彞
#====================================================
sub getSQL{ #鍔熻兘: 鐢熸垚浣滀笟瀵瑰簲鐨凷QL璇彞
      #鐢ㄦ硶: 灏哠QL璇彞宓屽湪涓や釜EOF_SQL
      #      鏍囪涔嬮棿,鏇挎崲鏍囩
#====================================================
$JOB_NAME  = $BASE::JOB_NAME; #override Minerva assignment
my $SQL=<<EOF_SQL;

--{PutScriptHere}

/*鍒涘缓涓存椂琛ㄥ姞杞藉綋鍓嶆暟鎹�*/

DELETE FROM
  #{BASE::CHN_RPSDATADBI}.DTL_ORG_BK_ID ALL
;

.IF ERRORCODE <> 0 THEN .GOTO QUITWITHERROR;


INSERT INTO
  CHN_RPSDATADB.DTL_ORG_BK_ID(BK_ID, BK_NAME, SUB_BK_ID, SUB_BK_NAME)
SELECT
  DISTINCT BK_ID,
  BK_NAME,
  SUB_BK_ID,
  SUB_BK_NAME
FROM
  #{BASE::CHN_RPSDATADBI}.TO4_ORG_BK_ID
;

.IF ERRORCODE <> 0 THEN .GOTO QUITWITHERROR;


         
EOF_SQL
return \$SQL;
}


#*******************  Main Program ********
#01. setup job frequence
BASE::setJobFrequency('d',''); #D,M,Q,Y,W

#02. check arguments
exit(1) if ( $#ARGV < 0 );
open(STDERR, ">&STDOUT");

#03. call bteq to execute the sql.
exit(BASE::run_bteq_command(getSQL()));

# <--------------!Script End!---------->
