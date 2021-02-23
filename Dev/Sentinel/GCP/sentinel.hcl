policy "block-project-wide-ssh-keys" {
    enforcement_level = "hard-mandatory"
}
policy "cloud-sql-databases-instance-requires-all-incoming-connections-to-use-ssl" {
    enforcement_level = "hard-mandatory"
}
policy "cloud-sql-databases-instances-are-not-open-to-the-world" {
    enforcement_level = "hard-mandatory"
}
policy "enable-connecting-to-serial-ports-is-not-enabled-for-vm-instance" {
    enforcement_level = "hard-mandatory"
}
policy "ensure-oslogin-is-enabled-for-a-project" {
    enforcement_level = "hard-mandatory"
}
policy "ensure-that-ip-forwarding-is-not-enabled-on-instances" {
    enforcement_level = "hard-mandatory"
}
policy "ensure-vm-disks-for-critical-vms-are-encrypted-with-customer-supplied-encryption-keys" {
    enforcement_level = "advisory"
}

