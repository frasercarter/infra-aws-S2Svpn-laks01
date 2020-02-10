#                                                                         #
#    ▄▄▄█████▓▓█████ ▄▄▄       ███▄ ▄███▓          ██▓ ▄████▄  ▓█████     #
#    ▓  ██▒ ▓▒▓█   ▀▒████▄    ▓██▒▀█▀ ██▒         ▓██▒▒██▀ ▀█  ▓█   ▀     #
#    ▒ ▓██░ ▒░▒███  ▒██  ▀█▄  ▓██    ▓██░         ▒██▒▒▓█    ▄ ▒███       #
#    ░ ▓██▓ ░ ▒▓█  ▄░██▄▄▄▄██ ▒██    ▒██          ░██░▒▓▓▄ ▄██▒▒▓█  ▄     #
#      ▒██▒ ░ ░▒████▒▓█   ▓██▒▒██▒   ░██▒         ░██░▒ ▓███▀ ░░▒████▒    #
#      ▒ ░░   ░░ ▒░ ░▒▒   ▓▒█░░ ▒░   ░  ░         ░▓  ░ ░▒ ▒  ░░░ ▒░ ░    #
#        ░     ░ ░  ░ ▒   ▒▒ ░░  ░      ░          ▒ ░  ░  ▒    ░ ░  ░    #
#      ░         ░    ░   ▒   ░      ░             ▒ ░░           ░       #
#                ░ OFX INFRASTRUCTURE & CLOUD ENGINEERING         ░  ░    #
#                                                                         #                                                        
<#          
.DESCRIPTION
  Inputs file for deploy.ps1
.NOTES
  Author: Fraser Elliot Carter Smith
#>

# Switch Account
Switch-RoleAlias master okta

#special variables
$cleanupmode = $true #<--- if true, script will delete all failed stacks only!

#configurable variables
$projectname = "cgw" #<--- becomes the prefix for all cgw stack names and vpn connection stacknames 
$uuid = 'laks01'
$region = "ap-southeast-2"
$vpntype = 'ipsec.1'
$tgwstackname = "transit-gateway" # must reference the stackname of the transit gateway cf stack for export referencing!

$sites = @( 
    [PSCustomObject]@{site="syd"; network="10.0.0.0/16"; asn="65000"; endpoints=@("49.255.71.2","14.202.31.162") ; redeploy=$false},
    [PSCustomObject]@{site="lon"; network="10.2.0.0/16"; asn="65002"; endpoints=@("80.169.133.98","167.98.115.234"); redeploy=$false},
    [PSCustomObject]@{site="sfo"; network="10.4.0.0/16"; asn="65004"; endpoints=@("4.14.110.226","12.205.169.10"); redeploy=$false},
    [PSCustomObject]@{site="tor"; network="10.6.0.0/16"; asn="65006"; endpoints=@("172.110.66.2"); redeploy=$true},
    [PSCustomObject]@{site="hkg"; network="10.8.0.0/16"; asn="65008"; endpoints=@("203.198.186.225","118.143.126.211"); redeploy=$false}
) 