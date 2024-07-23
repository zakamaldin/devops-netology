resource "yandex_kms_symmetric_key" "hw3-symetric-key" {
  name              = "hw3-asymetric-key"
  default_algorithm = "AES_256_HSM"
  rotation_period   = "24h" // equal to 1 year
}
