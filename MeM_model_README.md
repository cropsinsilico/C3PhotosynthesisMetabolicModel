#  National Data Service

##  Technical Description:
National Data Service is a set of tools to implement scientific data-oriented projects for diverse, dynamic, distributed teams of scientists.

## Code References
[https://bitbucket.org/nds-org/nds-labs](https://bitbucket.org/nds-org/nds-labs)

## License
Illinois OpenSource,

## Runtime Requirements:
OS: Ubuntu Linux 14.04
Packages:  Docker, python-2.7, 
Access to OpenStack and an openstack cli API file <openstack-rc.sh>

## Development Environment/Requirements:
Packages:  Python-2.7, 
Tools:  Eclipse

## Inputs:
Type:  Yaml
Size:  1-5k
Number: 10-100
Test Data Location: http://where.to.get.an.input.dataset.com/
-d:  debug mode - lots of output

## Outputs
Type:  Docker images
Size:  10-100MB
Count:  10-20
  
## Build Instructions
Setup dev system with build/run requirements.
Check-out codebase
cd Build
make -f Makefile.nds

## Run instructions
(run nds --help for a summary)
Arguments:
-d:  debug mode

## Test Instructions
How to test and verify that it is working properly

## Setup/Build/Run example output:
 - screen/terminal capture of building the tool and running it.

