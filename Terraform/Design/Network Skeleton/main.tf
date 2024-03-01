module "network" {
    source                         = "./networking"
    vpc_cidr                       = var.vpc_cidr
    vpc_name                       = var.vpc_name
    vpc_tenancy                    = var.vpc_tenancy
    vpc_enable_dns_support         = var.enable_dns_support
    vpc_enable_dns_hostnames       = var.enable_dns_hostnames
    pub_sub_names                  = var.public_subnet_names
    pub_sub_cidr                   = var.public_subnet_cidr
    pub_sub_az                     = var.public_subnet_az
    enable_map_public_ip_on_launch = var.enable_map_public_ip_on_launch
    pvt_sub_names                  = var.private_subnet_names
    pvt_sub_cidr                   = var.private_subnet_cidr
    pvt_sub_az                     = var.private_subnet_az 
    igw_name                       = var.igw
    nat_gtw                        = var.nat_gtw
    dev_pub_rt                     = var.public_route_table_names
    dev_pvt_rt                     = var.private_route_table_names
    sec_grp_name                   = var.Sec_grp_name
    sec_grp_description            = var.sec_grp_creation
    sg_inbound_ports               = var.sec_gp_inbound_ports
    sg_outbound_ports              = var.sec_gp_outbound_ports
    Sec_grp_tags                   = var.sec_grp_tags
    nacl_tag                       = var.nacl-tag
    nacl_inbound_ports             = var.nacl-inbound-ports
    nacl_outbound_ports            = var.nacl-outbound-ports
}

