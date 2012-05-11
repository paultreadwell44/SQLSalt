use MeasureMySkills
go

create certificate CertTest
encryption by password = 'certpassword'
with
	subject = 'Test Certificate',
	expiry_date = '2012-6-15'
go