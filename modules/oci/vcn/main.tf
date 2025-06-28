# Create a Virtual Cloud Network (VCN)
resource "oci_core_vcn" "vcn" {
  compartment_id = "compartment_id"
  cidr_block     = "172.16.0.0/16"
}
