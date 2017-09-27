private
errorFromResponse: resp
	^ MysqlError from: resp data
