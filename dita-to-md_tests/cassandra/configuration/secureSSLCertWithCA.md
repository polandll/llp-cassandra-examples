# Preparing SSL certificates for production {#secureSSLCertWithCA .task}

Steps to generate SSL certificates for client-to-node encryption or node-to-node encryption using a self-signed Certificate Authority \(CA\) in a production environment.

To use SSL encryption for client-to-node encryption or node-to-node encryption, SSL certificates must be generated using [openssl](https://www.openssl.org) and [keytool](http://docs.oracle.com/javase/8/docs/technotes/guides/security/SecurityToolsSummary.html). To validate the certificates, a self-signed Certificate Authority \(CA\) can be generated for production use with Apache Cassandra. The certificates generated using these instructions can be used for both internode and client-to-node encryption. For internode encryption, all nodes must have the truststore that provides the chain of trust for the CA. The certificates in the truststore can either be signed by the self-signed certificate authority used here or by a trusted and recognized public certificate authority.

1.  **Create a root CA certificate and key**
2.  Create the root CA certificate and key using `openssl req`. This command uses a certificate configuration file `gen_rootCa_cert.conf`.

    ```language-bash
    openssl req 
        -config gen_rootCa_cert.conf 
        -new -x509 -nodes 
        -subj /CN=rootCa/OU=TestCluster/O=YourCompany/C=US/ 
        -keyout rootCa.key 
        -out rootCa.crt
        -days 365
    ```

    ```
    # gen_rootCa_cert.conf
    [ req ]
    distinguished_name        = req_distinguished_name
    prompt		      = no
    output_password	    = myPass
    default_bits		= 2048
    
    [ req_distinguished_name ]
    C			    = US
    O			    = YourCompany
    OU			   = TestCluster
    CN			    = rootCa
    ```

    |**Option**|**Description**|
    |-config|Configuration file to use|
    |-new|Generate new certificate|
    |-x509|Outputs a self-signed certificate|
    |-nodes|If a private key is created, it is not encrypted|
    |-subj|Sets subject name when processing|
    |-keyout|Specify the private key filename to write|
    |-out|Specify the certificate filename to write|
    |-days|Specify the number of days for which to certify the certificate|

    The resulting files are the rootCA certificate and the rootCa private key.

    An example of the `rootCa.crt` file:

    ```
    -----BEGIN CERTIFICATE-----
    MIIDADCCAegCCQCWl1PhaMCqNDANBgkqhkiG9w0BAQsFADBCMQswCQYDVQQGEwJV
    UzEMMAoGA1UEChMDTExQMRQwEgYDVQQLEwtUZXN0Q2x1c3RlcjEPMA0GA1UEAxMG
    cm9vdENhMB4XDTE2MDkxMDAzNTkzOFoXDTE3MDkxMDAzNTkzOFowQjELMAkGA1UE
    BhMCVVMxDDAKBgNVBAoTA0xMUDEUMBIGA1UECxMLVGVzdENsdXN0ZXIxDzANBgNV
    BAMTBnJvb3RDYTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBANmFeE58
    eafNDPOYr6yFGNHxnwtiKRIs1CXF8pJQ1smgzM2v6D9UeixdZ5bDs0grK14a4UoE
    939ZCWKOLcgFi3394XwXHCf0mSjudrHd0ptAQKVSMqILRiJ5nJaR4yqfZBFbB2fl
    iQ5r9z2P20zTjlbbXZoJT83KF4Q+ke+VLLmEgSsLowjmq+JPP4Uzlp8dCyVLpAeD
    snf/T7/RaeIuZ+Wzje5pMlerY7Cv9A6te/SkFK1bZYzMsTCFOY6RBk1KdcVyDvhi
    co1b8Hv5hQLZ4v3nd6RtfmXNdL7YrqnLA9LnmS9ZFIk1w95Plg6hdBOuGT62W3ll
    IypMbZBOdWBMp0MCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAmoh6xkoa71yuVxJO
    O24wDfSNIpgAiP1uj7tvgza0yPs221o8p2e/34wdRaWdzLnc3Iu8cLpommuq9b82
    /WQNxdqFIJyyJwDTZUZ6VisSSXktDsW3mDPy10As+HJHuQ9adTsi/sOerh85FjmT
    BYbTDjX6BsIrwywgFBnb6uud2/GKlzTtlsi5LFLWKHVryxqng+ja4CZZbQ6/GT02
    hdP2d/17gGgCi1hIg5KJv/MoVhN0dLb6cueqfxLOOLGkqkXev2NiONzpjQITRwoF
    1NUo45DRHi25PAJ8+slUzvii4ADbe3P+SfEI6AETdnadCnA+WOffHI35OqxxePO9
    VqWu8w==
    -----END CERTIFICATE-----
    ```

    An example of the `rootCa.key` file:

    ```
    -----BEGIN PRIVATE KEY-----
    MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDZhXhOfHmnzQzz
    mK+shRjR8Z8LYikSLNQlxfKSUNbJoMzNr+g/VHosXWeWw7NIKyteGuFKBPd/WQli
    ji3IBYt9/eF8Fxwn9Jko7nax3dKbQEClUjKiC0YieZyWkeMqn2QRWwdn5YkOa/c9
    j9tM045W212aCU/NyheEPpHvlSy5hIErC6MI5qviTz+FM5afHQslS6QHg7J3/0+/
    0WniLmfls43uaTJXq2Owr/QOrXv0pBStW2WMzLEwhTmOkQZNSnXFcg74YnKNW/B7
    +YUC2eL953ekbX5lzXS+2K6pywPS55kvWRSJNcPeT5YOoXQTrhk+tlt5ZSMqTG2Q
    TnVgTKdDAgMBAAECggEAYsdSn8m08TeTtxdSR3TVlZk00VWNMxy6ZkDi7ADb2Qo1
    lv5X6FJzfKwZ+4P5aT95XS21uwhQYDtNoLzSG3AxLVDaUaCo/5f66XSI4DLMjgX6
    lVijd6TI/6TcMCAl2dgx+BOvZEX/HFZ5GzK1ssirbdQGSIoL/HbWgQ5s9TB38/Ja
    205ZB1lMUVsqdmY2M6vwY0xgr/xKXMgA3KvsW5PFBX1bgh8T6OLuIXTERYezGU4c
    c71JJt+1ejHSDInEEIV1peJer6qXopHDMQOcOSTzcZkGgDlFB7DHyGZM1ZsDRDOO
    f7Kq02A2c6CwJQeyGyRVIxDO6Ef73zw6UEtWzYCHeQKBgQDw9i8y0nlLgBLZaWor
    bJzJN9ML7CfOVw/RuGD2Y0z7su8SWQLLecVW1lwcaec80rD7e/SBr9Q/Kz68va13
    sVBx43QEDNp63g36bX917gu/hwBQs6RJlHGJmiNa/p5S01MaMM2YrX35gxBCQJHN
    hiE0yBzepfdGDELrEtOcttfCFwKBgQDnGMhpCpBEvYX43l9PQmnJ+P2w3lZoo8RF
    YUdpUuyH9n/mbopU3zu5f1roJefiEaxOozuL1sUOCsCN8qK2B3YCcX0LUvLrpAqR
    UD+So+eAF9tgFKHDvPLO7YA3iGPUl00cnwl2UXxV+7SONJRZsCbhbGO+T6QWq6YT
    eohMfvgbtQKBgFHPlAjSUyJiMoQkeUqTDsx2qq4SmRVCk/lle25MGrgecXMuS3eg
    OXMZRp7TChKpijNoS4S4mPx1h1B3qezIhAKW8i3p20f6Go7bHHqCvvRhNqcvxujA
    gKfycGyVpFWEsGNlDHj49pt/d0a3O4mnL6EHDF4/xSvAP/wmITjFD44zAoGBALbB
    jpwjUnxKNUze7xjLOMYVNutMqaEPAgSsLcFJZu0PL46YFKWR9LV51faJI5xQxada
    x5iLPEMilaysGalCtTyxa2YtLxbTH9hTUjMxk75lH4QYTOVy48JpaGCCaBCTptPf
    oagEQQPujpd3VWqoN9dF1IuIiAe1rxzwZiG4t5WRAoGBAKdypl5nZgtghlUxoazS
    CXfQsIT7g4y0LvoL9+EqdPk98Wl2Cb6MD1M89UqFhoyh65xE73EssGqDyypgYFGE
    HS/sMt9PP44ftfWRgQEGje6tJdKXLyUHSF+kKg4mormriOSm54sZD7Qk5RxEVcMq
    arKAClJVFkL9ARoAxRQWwidv
    -----END PRIVATE KEY-----
    ```

3.  **Verify the rootCa certificate**
4.  Verify the rootCa certificate.

    ```language-bash
     openssl x509
        -in rootCa.crt
        -text 
        -noout
    ```

    |**Option**|**Description**|
    |-in|Specify the certificate filename to verify|
    |-text|Print out the certificate in text form including the public key, signature algorithms, issuer and subject names, serial number any extensions present and any trust settings|
    |-noout|Prevents output of the encoded version of the request|

    This command prints output to the console that is similar to this example:

    ```
    Certificate:
        Data:
            Version: 1 (0x0)
            Serial Number: 10851234054762703412 (0x969753e168c0aa34)
        Signature Algorithm: sha256WithRSAEncryption
            Issuer: C=US, O=YourCompany, OU=TestCluster, CN=rootCa
            Validity
                Not Before: Sep 10 03:59:38 2016 GMT
                Not After : Sep 10 03:59:38 2017 GMT
            Subject: C=US, O=YourCompany, OU=TestCluster, CN=rootCa
            Subject Public Key Info:
                Public Key Algorithm: rsaEncryption
                    Public-Key: (2048 bit)
                    Modulus:
                        00:d9:85:78:4e:7c:79:a7:cd:0c:f3:98:af:ac:85:
                        18:d1:f1:9f:0b:62:29:12:2c:d4:25:c5:f2:92:50:
                        d6:c9:a0:cc:cd:af:e8:3f:54:7a:2c:5d:67:96:c3:
                        b3:48:2b:2b:5e:1a:e1:4a:04:f7:7f:59:09:62:8e:
                        2d:c8:05:8b:7d:fd:e1:7c:17:1c:27:f4:99:28:ee:
                        76:b1:dd:d2:9b:40:40:a5:52:32:a2:0b:46:22:79:
                        9c:96:91:e3:2a:9f:64:11:5b:07:67:e5:89:0e:6b:
                        f7:3d:8f:db:4c:d3:8e:56:db:5d:9a:09:4f:cd:ca:
                        17:84:3e:91:ef:95:2c:b9:84:81:2b:0b:a3:08:e6:
                        ab:e2:4f:3f:85:33:96:9f:1d:0b:25:4b:a4:07:83:
                        b2:77:ff:4f:bf:d1:69:e2:2e:67:e5:b3:8d:ee:69:
                        32:57:ab:63:b0:af:f4:0e:ad:7b:f4:a4:14:ad:5b:
                        65:8c:cc:b1:30:85:39:8e:91:06:4d:4a:75:c5:72:
                        0e:f8:62:72:8d:5b:f0:7b:f9:85:02:d9:e2:fd:e7:
                        77:a4:6d:7e:65:cd:74:be:d8:ae:a9:cb:03:d2:e7:
                        99:2f:59:14:89:35:c3:de:4f:96:0e:a1:74:13:ae:
                        19:3e:b6:5b:79:65:23:2a:4c:6d:90:4e:75:60:4c:
                        a7:43
                    Exponent: 65537 (0x10001)
        Signature Algorithm: sha256WithRSAEncryption
             9a:88:7a:c6:4a:1a:ef:5c:ae:57:12:4e:3b:6e:30:0d:f4:8d:
             22:98:00:88:fd:6e:8f:bb:6f:83:36:b4:c8:fb:36:db:5a:3c:
             a7:67:bf:df:8c:1d:45:a5:9d:cc:b9:dc:dc:8b:bc:70:ba:68:
             9a:6b:aa:f5:bf:36:fd:64:0d:c5:da:85:20:9c:b2:27:00:d3:
             65:46:7a:56:2b:12:49:79:2d:0e:c5:b7:98:33:f2:d7:40:2c:
             f8:72:47:b9:0f:5a:75:3b:22:fe:c3:9e:ae:1f:39:16:39:93:
             05:86:d3:0e:35:fa:06:c2:2b:c3:2c:20:14:19:db:ea:eb:9d:
             db:f1:8a:97:34:ed:96:c8:b9:2c:52:d6:28:75:6b:cb:1a:a7:
             83:e8:da:e0:26:59:6d:0e:bf:19:3d:36:85:d3:f6:77:fd:7b:
             80:68:02:8b:58:48:83:92:89:bf:f3:28:56:13:74:74:b6:fa:
             72:e7:aa:7f:12:ce:38:b1:a4:aa:45:de:bf:63:62:38:dc:e9:
             8d:02:13:47:0a:05:d4:d5:28:e3:90:d1:1e:2d:b9:3c:02:7c:
             fa:c9:54:ce:f8:a2:e0:00:db:7b:73:fe:49:f1:08:e8:01:13:
             76:76:9d:0a:70:3e:58:e7:df:1c:8d:f9:3a:ac:71:78:f3:bd:
             56:a5:ae:f3
    ```

5.  **Generate public/private key pair and keystore for each node**
6.  Repeat this command for each node. The files can be generated on a single node and distributed out to the nodes after the entire process is completed.

    ```screen
    keytool -genkeypair 
        -keyalg RSA 
        -alias 10.200.175.15 
        -keystore 10.200.175.15.jks 
        -storepass myKeyPass 
        -keypass myKeyPass 
        -validity 365 
        -keysize 2048 
        -dname "CN=10.200.175.15, OU=TestCluster, O=YourCompany, C=US"   
    
    ```

    |**Option**|**Description**|
    |-genkeypair|Command to generate a public/private key pair|
    |-keyalg|Specify the key algorithm|
    |-alias|Assign an unique alias by which keystore entry is accessed|
    |-keystore|Specify the keystore filename|
    |-storepass|Specify the keystore password|
    |-keypass|Specify the private key password|
    |-validity|Specify the number of days for the keystore certificate validity|
    |-keysize|Specify the size of the generated key|
    |-dname|Specify the X.500 Distinguished Name to be associated with the value of alias|

    In this example, the node IP address is `10.200.175.15` and the keystore filename incorporates that IP address with a suffix of `jks` \(Java KeyStore\). While the keystore can be named with any convention, the examples here use the IP address in order to map the files to the nodes. The `dname` sets the `CN` value to the node's IP address or FQDN as well. The `storepass` and `keypass` must be the same value.

7.  **Check certificates**
8.  The certificates can be checked once generated:

    ```screen
    keytool -list 
        -keystore 10.200.175.15.jks 
        -storepass myKeyPass
    ```

    An example keystore file:

    ```
    Keystore type: JKS
    Keystore provider: SUN
    
    Your keystore contains 1 entry
    
    10.200.175.15, Sep 10, 2016, PrivateKeyEntry, 
    Certificate fingerprint (SHA1): D6:1B:6C:FE:E3:3B:4B:3D:E0:F0:38:EA:54:AD:F0:E7:1E:D4:CB:4D
    ```

9.  **Export certificate signing request \(CSR\) for each node**
10. Once the node certificate and key are generated, a certificate signing request \(CSR\) is exported. The CSR will be signed with the rootCa certificate to verify that the node's certificate is trusted.

    ```screen
    keytool -certreq
        -keystore 10.200.175.15.jks 
        -alias 10.200.175.15 
        -file 10.200.175.15.csr 
        -keypass myKeyPass 
        -storepass myKeyPass 
        -dname "CN=10.200.175.15, OU=TestCluster, O=YourCompany, C=US"  
    
    ```

    |**Option**|**Description**|
    |-certreq|Command to export a CSR|
    |-file|Specify the CSR filename|
    |-alias|Assign an unique alias by which keystore entry is accessed|
    |-keystore|Specify the keystore filename|
    |-storepass|Specify the keystore password|
    |-keypass|Specify the private key password|
    |-dname|Specify the X.500 Distinguished Name to be associated with the value of alias|

    An example CSR file:

    ```
    -----BEGIN NEW CERTIFICATE REQUEST-----
    MIICvDCCAaQCAQAwRzELMAkGA1UEBhMCVVMxDDAKBgNVBAoTA0xMUDESMBAGA1UECxMJTExQMDkw
    NzE2MRYwFAYDVQQDEw0xMC4yMDAuMTc1LjE1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
    AQEAhUJWFQ+9Xgs8KfhLYCBi8i0csY44YkCBFAz3jh6g80wdCqYetYcNxWi+3rgAFL6BAibt23xG
    qBKtNszxyUu8M7ocfw+dVeT4YQJWE0TNAnwlijx+jyl2IKCFtuON3NmGvvHviPDyNyz2VuB7jlA3
    fGuCSsXEzpDXdStKZNcozeIxnmLRv2VKkp8edOX0Bi3QOxwKgwzZQ0/Z7yWaixl1WB2YKzY9s1Bn
    oEoRHdFeQZR7f9QuQYBwIKsCx3cFsiEQJnpKqbZYLFrPmpMrR7ynLx6MGZVDuLfrXp/yFyuHmamI
    M80CGvKljwr/onalDY2F5AeSdUyBM3vVTWrC9n9jwQIDAQABoDAwLgYJKoZIhvcNAQkOMSEwHzAd
    BgNVHQ4EFgQUSbrkacD4XXCIaJQtX+7/en3Z8r8wDQYJKoZIhvcNAQELBQADggEBAAxU2FbQxy21
    EHcnfC4YETDQvXuwv4qQzcT61faZEjmznZ9ekm8ckzV5NlHpyArk12EO13twh94U56ZItKfiYOKW
    tP5wUGcoYhdyQnG0p6wunVRJAMidoZMAkjJ6bXwDwgNqnlKL48iGD8ZnguVUM353KwTDm1mvJ4yE
    ssEcnBKd4lDzfZN+yx3pmyCr/MjMCODLF7VVMRH5FpQZ0+uGAIq0fx8FeEugxGie4tkzqP3xkkUB
    RDKkfrUC8Z61gL3K1LpLZ77a1okpP3cNkvSStVgbhLH9qwnhCORNGHy+NyZLm1a+hS4QCAJzRKlC
    nsdwUTp+HXUtyNLd7GJHGLPu0YY=
    -----END NEW CERTIFICATE REQUEST-----
    ```

11. **Sign node certificate with rootCa for each node**
12. The CSR is input, signed with the rootCa certificate and a signed node certificate is created.

    ```screen
    openssl x509 
        -req 
        -CA rootCa.crt 
        -CAkey rootCa.key 
        -in 10.200.175.15.csr 
        -out 10.200.175.15.crt_signed 
        -days 365 
        -CAcreateserial 
        -passin pass:myPass
    
    ```

    |**Option**|**Description**|
    |-req|Specify that the input file is a CSR|
    |-CA|Identify the rootCa certificate|
    |-CAkey|Identify the rootCa key|
    |-in|Specify the input filename from which to read a certificate|
    |-out|Specify the output filename for the signed certificate|
    |-CAcreateserial|Specify that a CA serial number file is created if it does not exist|
    |-days|Specify the number of days for which to certify the certificate|
    |-passin|Specify the key password source|

    An example of the signed certificate:

    ```
    -----BEGIN CERTIFICATE-----
    MIIDBTCCAe0CCQDBKbNGSE8C9DANBgkqhkiG9w0BAQsFADBCMQswCQYDVQQGEwJV
    UzEMMAoGA1UEChMDTExQMRQwEgYDVQQLEwtUZXN0Q2x1c3RlcjEPMA0GA1UEAxMG
    cm9vdENhMB4XDTE2MDkxMDA0MDAzMFoXDTE3MDkxMDA0MDAzMFowRzELMAkGA1UE
    BhMCVVMxDDAKBgNVBAoTA0xMUDESMBAGA1UECxMJTExQMDkwNzE2MRYwFAYDVQQD
    Ew0xMC4yMDAuMTc1LjE1MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
    hUJWFQ+9Xgs8KfhLYCBi8i0csY44YkCBFAz3jh6g80wdCqYetYcNxWi+3rgAFL6B
    Aibt23xGqBKtNszxyUu8M7ocfw+dVeT4YQJWE0TNAnwlijx+jyl2IKCFtuON3NmG
    vvHviPDyNyz2VuB7jlA3fGuCSsXEzpDXdStKZNcozeIxnmLRv2VKkp8edOX0Bi3Q
    OxwKgwzZQ0/Z7yWaixl1WB2YKzY9s1BnoEoRHdFeQZR7f9QuQYBwIKsCx3cFsiEQ
    JnpKqbZYLFrPmpMrR7ynLx6MGZVDuLfrXp/yFyuHmamIM80CGvKljwr/onalDY2F
    5AeSdUyBM3vVTWrC9n9jwQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQCqqXSKsKlW
    sivk9/ap57fVbvYWj34FCmCYEWAPTrj0gEDwEP2WU2/813FF3fiXeFGwuNcm3XHl
    0jsPsrckVmtko2ERGHCsQS7RlRlbRRzinQZ6zQaHFyDqsVBGeb/FRE0eJPO2OWQA
    hksT1y7DAMv0kFyzvHDGtJRzWgXMpjc5LrWto46+JByx+9JjVI5a9DuKdvuoJGL/
    CShFW/AWyOBk8LFlx+qzcYBy1R6WYqqE+pIhsq8X9Jtb6/ZymZBw7Ek9XH8ULNjV
    S8QfiEkEXMjH+s+7Pofky7/8/udrEemQgLcIY3xKnlp+Rsz/wH21ZdKGs/lhbIzm
    Xo+7pYd2dqHT
    -----END CERTIFICATE-----
    ```

13. **Verify the signed certificate for each node**
14. Check the signed certificate by designating the rootCa certificate and the signed certificate to verify:

    ```screen
    openssl verify -CAfile rootCa.crt 10.200.175.15.crt_signed
    ```

    If the verification succeeds, a console message is returned:

    ```
    10.200.175.15.crt_signed: OK
    ```

15. **Import rootCa certificate to each node keystore**
16. Use `keytool -importcert` to import the rootCa certificate into each node keystore:

    ```screen
    keytool -importcert 
        -keystore 10.200.175.15.jks 
        -alias rootCa  
        -file rootCa.crt 
        -noprompt  
        -keypass myKeyPass 
        -storepass myKeyPass 
    
    ```

    The `-noprompt` option allows the command to use the specified values rather than prompting for input.

    The keystore file now has two entries, one for the rootCa certificate and one for the node certificate:

    ```
    Keystore type: JKS
    Keystore provider: SUN
    
    Your keystore contains 2 entries
    
    rootca, Sep 10, 2016, trustedCertEntry, 
    Certificate fingerprint (SHA1): CD:F2:A5:6F:EC:DA:B9:9E:C1:8D:89:09:AE:FF:DB:BD:56:F6:7D:79
    10.200.175.15, Sep 10, 2016, PrivateKeyEntry, 
    Certificate fingerprint (SHA1): D6:1B:6C:FE:E3:3B:4B:3D:E0:F0:38:EA:54:AD:F0:E7:1E:D4:CB:4D
    ```

17. **Import node's signed certificate into node keystore for each node**
18. ```screen
keytool -importcert
    -keystore 10.200.175.15.jks 
    -alias 10.200.175.15  
    -file 10.200.175.15.crt_signed 
    -noprompt 
    -keypass myKeyPass 
    -storepass myKeyPass 

```

    The resulting file will appear similar to the result from the previous step, but the node certificate originally created is replaced with the signed node certificate.

19. **Create a server truststore**
20. A server truststore file can be used to establish a chain of trust between the nodes of the cluster.

    ```screen
    keytool -importcert 
        -keystore generic-server-truststore.jks 
        -alias rootCa  
        -file rootCa.crt 
        -noprompt
        -keypass myPass 
        -storepass truststorePass 
    ```

    The resulting truststore file can be inspected using the `keytool -list` command:

    ```screen
    keytool -list 
        -keystore generic-server-truststore.jks 
        -storepass truststorePass
    ```

    and an example of the truststore file will include a rootCa certificate entry:

    ```
    Keystore type: JKS
    Keystore provider: SUN
    
    Your keystore contains 1 entry
    
    rootca, Sep 10, 2016, trustedCertEntry, 
    Certificate fingerprint (SHA1): CD:F2:A5:6F:EC:DA:B9:9E:C1:8D:89:09:AE:FF:DB:BD:56:F6:7D:79
    ```

21. **Copy the truststore file to each node**
22. The truststore file must be copied to each node. If a node is used to generate the file, copy the file to a location of choice and name the file with a standard format, such as `server-truststore.jks`. This example shows the copy command for a Linux server with a tarball installation of Cassandra and stores the file in the configuration directory of Cassandra:

    ```screen
    cp ~/generic-server-truststore.jks /usr/local/lib/cassandra/conf/server-truststore.jks
    ```

23. **Copy the each node keystore file to each node**
24. Each node file must have a copy of its keystore file. If a node is used to generate the file, copy the file to a location of choice. This example shows the secure remote copy commands for a Linux server with a tarball installation of Cassandra, where the certificates were generated on a single node. The file is stored in the configuration directory of Cassandra in this example:

    ```screen
    scp -r 10.200.175.150.jks /usr/local/lib/cassandra/conf/10.200.175.150.jks
    ```


**Parent topic:** [SSL encryption](../../cassandra/configuration/secureSSLEncryptTOC.md)

