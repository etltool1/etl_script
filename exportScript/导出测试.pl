User=root
Password=123456
#数据文件绝对路径
DataFile=12/12
#数据文件分隔符
DataDelimiter=12
#编码格式 界面未维护该值
DataFileFormat=data_format
#SchemaName名
SchemaName=etl_tool
#表名
TableName=table

#执行数据库加载脚本
mysql -u${root} -p${Password} -e "select * from ${SchemaName}.${TableName} into outfile '${DataFile}' Fields TERMINATED by '${DataDelimiter}'"

if [ $? -ne 0];then
	echo "${DataFile} Data export complete unsuccessful"
	exit 1
else 
	echo "${DataFile} Data export complete successful"
fi
	exit 0
