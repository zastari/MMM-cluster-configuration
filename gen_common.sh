#!/bin/bash
# Generate mmm_{common,mon,mon_log}_C{1..n} from clusters.txt
workdir="/etc/mysql-mmm/stage"

while read cluster host1 host2 hip1 hip2 writer reader monpass agentpass replpass; do
    cp -af ${workdir}/mmm_common_skel.conf ${workdir}/mmm_common_${cluster}.conf
    sed -i -e "s/hxx1/${host1}/g" \
        -e "s/hxx2/${host2}/g"    \
        -e "s/hxxip1/${hip1}/g"   \
        -e "s/hxxip2/${hip2}/g"   \
        -e "s/mmmw1/${writer}/g"  \
        -e "s/replpass/${replpass}/g"   \
        -e "s/agentpass/${agentpass}/g" \
        -e "s/mmmr1/${reader}/g" ${workdir}/mmm_common_${cluster}.conf

    cp -af ${workdir}/mmm_mon_skel.conf ${workdir}/mmm_mon_${cluster}.conf

    port_count="${cluster:1}"
    (("${port_count}" < "10")) && port_count="0${port_count}"

    sed -i -e "s/cxx/${cluster}/g" \
           -e "s/hxxip1/${hip1}/g" \
           -e "s/hxxip2/${hip2}/g" \
           -e "s/monpass/${monpass}/g" \
           -e "s/portxx/${port_count}/g" ${workdir}/mmm_mon_${cluster}.conf

    cp -af ${workdir}/mmm_mon_log_skel.conf ${workdir}/mmm_mon_log_${cluster}.conf
    sed -i -e "s/cxx/${cluster}/g" ${workdir}/mmm_mon_log_${cluster}.conf

done < ${workdir}/clusters.txt
