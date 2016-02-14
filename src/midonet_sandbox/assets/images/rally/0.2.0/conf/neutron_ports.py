from rally import consts
from rally.plugins.openstack import scenario
from rally.plugins.openstack.scenarios.neutron import utils
from rally.task import validation

class NeutronPorts(utils.NeutronScenario):
    """Modified Benchmark scenarios for Neutron."""
    @validation.number("ports_per_network", minval=1, integer_only=True)
    @validation.required_services(consts.Service.NEUTRON)
    @validation.required_openstack(users=True)
    @scenario.configure(context={"cleanup": ["neutron"]})
    def create_ports(self,
                     network_create_args=None,
                     port_create_args=None,
                     ports_per_network=None):
        """Create and a given number of ports.

        :param network_create_args: dict, POST /v2.0/networks request
                                    options. Deprecated.
        :param port_create_args: dict, POST /v2.0/ports request options
        :param ports_per_network: int, number of ports for one network
        """
        network = self._get_or_create_network(network_create_args)
        for i in range(ports_per_network):
            self._create_port(network, port_create_args or {})
