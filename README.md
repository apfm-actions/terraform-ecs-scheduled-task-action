# Terraform ECS Schedule Task Action
Schedule an ECS task in CloudWatch using Terraform

## Usage

```
  - name: My Project
    uses: apfm-actions/terraform-project-base-action@master
    with:
      project: examples
      owner: MyTeam
      email: myteam@mydomain.org
      tf_assume_role: TerraformApply
      remote_state_bucket: apfm-terraform-remotestate
      remote_lock_table: terraform-statelock
      shared_state_key: /shared-infra/remotestate.file
  - name: My Service
    uses: apfm-actions/terraform-ecs-scheduled-task-action@master
    with:
      name: do-stuff
      schedule: '0 7 * * ? *'
      debug: false
```


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_log_group"></a> [cloudwatch\_log\_group](#input\_cloudwatch\_log\_group) | CloudWatch Log Group for ECS Scheduled Task. If not defined, name is used instead | `string` | n/a | yes |
| <a name="input_schedule"></a> [cloudwatch\_rule](#input\_cloudwatch\_rule) | Schedule for the task in cron format | `string` | n/a | yes |
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | Default ECS cluster ARN  If not defined then cluster named `default' will be used.` | `string` | `""` | no |
| <a name="input_command"></a> [command](#input\_command) | Use specific command when launching the task.  If omitted the default Docker CMD registered in the Dockerfile will be used. | `string` | `""` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | Fargate CPU time allocation | `number` | `256` | no |
| <a name="input_enable"></a> [enable](#input\_enable) | n/a | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment variables to pass to container at launch | `map` | `{}` | no |
| <a name="input_exec_role_arn"></a> [exec\_role\_arn](#input\_exec\_role\_arn) | Role to pull the container and push logs to CW.  If omotted the default Amazon role will be used | `string` | `""` | no |
| <a name="input_image"></a> [image](#input\_image) | Container image to use when launching the task | `string` | n/a | yes |
| <a name="input_memory"></a> [memory](#input\_memory) | Fargate Memory size allication | `number` | `512` | no |
| <a name="input_name"></a> [name](#input\_name) | Name value to use for task related objects | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | AWS Region to deploy to | `string` | `"us-west-2"` | no |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | Environment variables to set from the secrets store at launch | `map` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Comma separated list of subnets which the container can be deployed to | `list` | `""` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | Role that provides the security context that the container actually runs in | `string` | `""` | no |

## Outputs

No outputs.
