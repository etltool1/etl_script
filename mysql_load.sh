User=root
Password=123456
#数据文件绝对路径
DataFile=/data/export/EXPORT_FILE_NAME
#数据文件分隔符
DataDelimiter=/
#编码格式
DataFileFormat=data_format
#SchemaName名
SchemaName=etl_tool
#表名
TableName=ftp_script_info


#执行数据库加载脚本
mysql -u${root} -p${Password} -e "LOAD DATA LOCAL INFILE '${DataFile}' into table  ${SchemaName}.${TableName}  FIELDS TERMINATED BY '${DataDelimiter}' LINES TERNINATED BY '\n'"

if [ $? -ne 0];then
	echo "${DataFile} Data load complete unsuccessful"
	exit 1
else 
	echo "${DataFile} Data load complete successful"
fi
	exit 0