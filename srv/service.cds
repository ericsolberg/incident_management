using { sap.capire.incidents as my } from '../db/schema';

@path : '/service/incident_management'
service ProcessorService
{
    @odata.draft.enabled
    entity Incidents as
        projection on my.Incidents;

    entity Customers as projection on my.Customers
    {
        *,
        firstName || ' ' || lastName as name : String
    };

    entity Conversations as
        projection on my.Conversations;

    entity Status as
        projection on my.Status;

    entity Urgency as
        projection on my.Urgency;
}

annotate ProcessorService with @requires :
[
    'support'
];
