CREATE TABLE test.encryption_test_a (a int primary key) WITH
   COMPRESSION = { 'class': 'Encryptor', 'chunk_length_kb' : 1 };

CREATE TABLE test.encryption_test_b (b int primary key) WITH
   COMPRESSION = {
      'class': 'EncryptingLZ4Compressor',
      'cipher_algorithm' : 'AES/ECB/PKCS5Padding', 
      'secret_key_strength' : 128,
      'system_key_file': 'AES-256'};

CREATE TABLE test.encryption_test_c (c int primary key) WITH
      COMPRESSION = {
            'class': 'EncryptingLZ4Compressor',
            'cipher_algorithm' : 'AES/ECB/PKCS5Padding',
            'secret_key_strength' : 128};

CREATE TABLE test.encryption_test_d (d int primary key) WITH
   COMPRESSION = {
      'class': 'EncryptingLZ4Compressor',
      'cipher_algorithm' : 'DESede/CBC/PKCS5Padding',
      'secret_key_strength' : 112,
      'system_key_file' : 'test-key' };

CREATE TABLE test.encryption_test_e (e int primary key) WITH
      COMPRESSION = {
            'class': 'EncryptingLZ4Compressor',
            'cipher_algorithm' : 'AES/ECB/PKCS5Padding',
            'secret_key_strength' : 128};
