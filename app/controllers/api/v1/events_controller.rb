require 'savon'

class Api::V1::EventsController < ApplicationController
  def index
    #### using wsdl with savon gem does work due to SSL error (invalid certificate
    #### client = Savon.client(wsdl: 'https://test.resortsuitemobile.com:3002/wso2wsas/services/RSWS?wsdl')
    
    host = "https://test.resortsuitemobile.com:3002"
    path = "/wso2wsas/services/RSWS.RSWSSOAP"
    http = Net::HTTP.new(host)

    xml = '
			<?xml version="1.0" encoding="UTF-8" ?>
			<soapenv:Envelope xmlns:d="http://www.resortsuite.com/RSWS/v1/Dining/Types" xmlns:r="http://www.resortsuite.com/RSWS/v1/Retail/Types" xmlns:g="http://www.resortsuite.com/RSWS/v1/Golf/Types" xmlns:p="http://www.resortsuite.com/RSWS/v1/PMS/Types" xmlns:f="http://www.resortsuite.com/RSWS/v1/Folio/Types" xmlns:k="http://www.resortsuite.com/RSWS/v1/Ski/Types" xmlns:s="http://www.resortsuite.com/RSWS/v1/Spa/Types" xmlns:c="http://www.resortsuite.com/RSWS/v1/Customer/Types" xmlns:b="http://www.resortsuite.com/RSWS/v1/Club/Types" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
					<soapenv:Body>
							<s:FetchSpaClassesRequest>
									<EndDate>2021-10-15</EndDate>
									<Language>English</Language>
									<Location>200</Location>
									<StartDate>2021-01-20</StartDate>
									<WebFolioId>50370</WebFolioId>
							</s:FetchSpaClassesRequest>
					</soapenv:Body>
			</soapenv:Envelope> 
    '

    resp = http.post(path, xml, { 'Content-Type' => 'text/xml;charset=utf-8', 'SOAPAction': 'FetchSpaClasses' })

    render json: {data: resp.body}, status: 200
  end
end
