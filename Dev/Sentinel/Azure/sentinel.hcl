policy "databases-ensure-auditing-is-set-to-on" {
    enforcement_level = "hard-mandatory"
}
policy "databases-ensure-auditing-retention-greater-than-90-days" {
    enforcement_level = "hard-mandatory"
}
policy "databases-ensure-azure-ad-admin-is-configured" {
    enforcement_level = "hard-mandatory"
}
policy "compute-managed-disk-encryption-is-enabled" {
    enforcement_level = "hard-mandatory"
}
policy "compute-only-approved-extensions-are-installed" {
    enforcement_level = "hard-mandatory"
}
policy "databases-mysql-enforce-ssl-connection-is-enabled" {
    enforcement_level = "hard-mandatory"
}
policy "databases-psql-enforce-ssl-connection-is-enabled" {
    enforcement_level = "hard-mandatory"
}
policy "networking-deny-any-sql-database-ingress" {
    enforcement_level = "hard-mandatory"
}
policy "networking-deny-public-rdp-nsg-rules" {
    enforcement_level = "hard-mandatory"
}
policy "networking-deny-public-ssh-nsg-rules" {
    enforcement_level = "hard-mandatory"
}
policy "networking-enforce-network-watcher-flow-log-retention-period" {
    enforcement_level = "hard-mandatory"
}
policy "storage-blob-public-access-level-set-to-private" {
    enforcement_level = "hard-mandatory"
}
policy "storage-default-network-access-rule-set-to-deny" {
    enforcement_level = "hard-mandatory"
}
policy "storage-queue-logging-is-enabled" {
    enforcement_level = "hard-mandatory"
}
policy "storage-secure-transfer-required-is-enabled" {
    enforcement_level = "hard-mandatory"
}
policy "storage-trusted-microsoft-services-is-enabled" {
    enforcement_level = "hard-mandatory"
}
