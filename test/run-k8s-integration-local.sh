#!/bin/bash

set -o nounset
set -o errexit

readonly PKGDIR=${GOPATH}/src/sigs.k8s.io/gcp-compute-persistent-disk-csi-driver
source "${PKGDIR}/deploy/common.sh"

ensure_var GCE_PD_CSI_STAGING_IMAGE
ensure_var GCE_PD_SA_DIR

make -C ${PKGDIR} test-k8s-integration
${PKGDIR}/bin/k8s-integration-test --kube-version=master --run-in-prow=false --staging-image=${GCE_PD_CSI_STAGING_IMAGE} --service-account-file=${GCE_PD_SA_DIR}/cloud-sa.json --deploy-overlay-name=dev
#${PKGDIR}/bin/k8s-integration-test --kube-version=master --run-in-prow=false --staging-image=${GCE_PD_CSI_STAGING_IMAGE} --service-account-file=${GCE_PD_SA_DIR}/cloud-sa.json --deploy-overlay-name=dev --bringup-cluster=false --teardown-cluster=false --local-k8s-dir=$KTOP
