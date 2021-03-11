policy "databases-ensure-auditing-is-set-to-on" {
    enforcement_level = "soft-mandatory"
}
policy "databases-ensure-auditing-retention-greater-than-90-days" {
    enforcement_level = "soft-mandatory"
}
policy "databases-ensure-azure-ad-admin-is-configured" {
    enforcement_level = "soft-mandatory"
}
policy "compute-managed-disk-encryption-is-enabled" {
    enforcement_level = "soft-mandatory"
}
policy "compute-only-approved-extensions-are-installed" {
    enforcement_level = "soft-mandatory"
}
policy "databases-mysql-enforce-ssl-connection-is-enabled" {
    enforcement_level = "soft-mandatory"
}
policy "databases-psql-enforce-ssl-connection-is-enabled" {
    enforcement_level = "soft-mandatory"
}
policy "networking-deny-any-sql-database-ingress" {
    enforcement_level = "soft-mandatory"
}
policy "networking-deny-public-rdp-nsg-rules" {
    enforcement_level = "soft-mandatory"
}
policy "networking-deny-public-ssh-nsg-rules" {
    enforcement_level = "soft-mandatory"
}
policy "networking-enforce-network-watcher-flow-log-retention-period" {
    enforcement_level = "soft-mandatory"
}
policy "storage-blob-public-access-level-set-to-private" {
    enforcement_level = "soft-mandatory"
}
policy "storage-default-network-access-rule-set-to-deny" {
    enforcement_level = "soft-mandatory"
}
policy "storage-queue-logging-is-enabled" {
    enforcement_level = "soft-mandatory"
}
policy "storage-secure-transfer-required-is-enabled" {
    enforcement_level = "soft-mandatory"
}
policy "storage-trusted-microsoft-services-is-enabled" {
    enforcement_level = "soft-mandatory"
}