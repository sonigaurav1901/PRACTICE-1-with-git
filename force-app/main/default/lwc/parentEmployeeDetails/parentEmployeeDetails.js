import { LightningElement, wire } from "lwc";
import { gql, graphql } from "lightning/uiGraphQLApi";

export default class ParentEmployeeDetails extends LightningElement {
    ListOfAcc = [];
    AccountName = [];
    AccountData ;

    @wire(graphql, {
        query: gql`
            query AccountWithName {
                uiapi {
                    query {
                        Account(where: { Name: { like: "%Group%" } }) {
                            edges {
                                node {
                                    Id
                                    Name {
                                        value
                                    }
                                    Contacts {
                                        edges {
                                            node {
                                                Id
                                                Name {
                                                    value
                                                }
                                                Email {
                                                    value
                                                }
                                                Amount__c {
                                                    value
                                                    displayValue
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        `
    })
    propertyOrFunction({ error, data }) {
        if (data) {
            this.AccountData = data.uiapi.query.Account.edges.map((edge) => ({
                ...edge.node,
                Contacts: edge.node.Contacts.edges.map((edge2) => edge2.node)
            }));

            console.log("data is :- " + JSON.stringify(this.AccountData));
            
        } else if (error) {
            console.log("error is :- " + error);
        }
    }

    dataProcess() {}
}