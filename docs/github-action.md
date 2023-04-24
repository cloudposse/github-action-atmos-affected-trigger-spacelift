<!-- markdownlint-disable -->

## Inputs

| Name | Description | Default | Required |
|------|-------------|---------|----------|
| atmos-config-path | A path to the folder where atmos.yaml is located | . | false |
| atmos-version | The version of atmos to install if install-atmos is true | latest | false |
| default-branch | The default branch to use for the base ref. | ${{ github.event.repository.default\_branch }} | false |
| deploy | A flag to indicate if a deployment should be triggered. If false, a preview will be triggered. | false | false |
| github-token | A GitHub token for running the spacelift-io/setup-spacectl action | N/A | true |
| head-ref | The head ref to checkout. If not provided, the head default branch is used. | N/A | false |
| install-atmos | Whether to install atmos | true | false |
| install-jq | Whether to install jq | false | false |
| install-spacectl | Whether to install spacectl | true | false |
| install-terraform | Whether to install terraform | true | false |
| jq-force | Whether to force the installation of jq | true | false |
| jq-version | The version of jq to install if install-jq is true | 1.6 | false |
| spacectl-version | The version of spacectl to install if install-spacectl is true | latest | false |
| spacelift-api-key-id | The SPACELIFT\_API\_KEY\_ID | N/A | true |
| spacelift-api-key-secret | The SPACELIFT\_API\_KEY\_SECRET | N/A | true |
| spacelift-endpoint | The Spacelift endpoint. For example, https://unicorn.app.spacelift.io | N/A | true |
| terraform-version | The version of terraform to install if install-terraform is true | latest | false |


<!-- markdownlint-restore -->
