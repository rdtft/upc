MERCHANT_ID = 1754002

all: keys signature

keys:
	openssl genrsa -out $(MERCHANT_ID).pem 1024
	openssl req -new -key $(MERCHANT_ID).pem -x509 -days 365 -config config/config.dat -out $(MERCHANT_ID).crt
	openssl x509 -in $(MERCHANT_ID).crt -noout -pubkey > $(MERCHANT_ID).pub

signature:
	openssl dgst -sha1 -sign $(MERCHANT_ID).pem data/datafile > signature.bin
	openssl base64 -e -in signature.bin -out signature

test:
	openssl base64 -d -in signature -out signature.bin
	openssl dgst -sha1 -verify data/test-server.pub -signature signature.bin data/from_gateway

clean:
	rm -vf *.pem *.crt *pub signature*

.PHONY: clean keys signature test
