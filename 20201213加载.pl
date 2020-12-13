User=root
Password=123456
#数据文件绝对路径
DataFile=6666/666
#数据文件分隔符
DataDelimiter=666
#编码格式
DataFileFormat=data_format
#SchemaName名
SchemaName=etl_tool
#表名
TableName=6666


#执行数据库加载脚本
mysql -u${root} -p${Password} -e "LOAD DATA LOCAL INFILE '${DataFile}' into table  ${SchemaName}.${TableName}  FIELDS TERMINATED BY '${DataDelimiter}' LINES TERNINATED BY '\n'"

if [ $? -ne 0];then
	echo "${DataFile} Data load complete unsuccessful"
	exit 1
else 
	echo "${DataFile} Data load complete successful"
fi
	exit 0
