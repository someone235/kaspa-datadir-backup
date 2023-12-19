#!/bin/bash
set -ex
cd /tmp
sudo systemctl stop rusty-kaspa
archive=rusty-kaspa-$(date +'%F_%H-%M').tar.gz
#tar czf $archive /home/ori/.rusty-kaspa/kaspa-mainnet
tar cf - /home/ori/.rusty-kaspa/kaspa-mainnet -P | pv -f -s $(du -sb /home/ori/.rusty-kaspa/kaspa-mainnet | awk '{print $1}') | gzip > $archive
sudo systemctl start rusty-kaspa 
aws s3 cp $archive s3://rust-datadirs/$archive
rm $archive

