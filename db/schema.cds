namespace sap.capire.incidents;

using
{
    Language,
    Currency,
    Country,
    sap.common.CodeList,
    cuid,
    managed,
    temporal,
    User,
    extensible
}
from '@sap/cds/common';

entity Incidents : managed
{
    key ID : UUID;
    title : String(100)
        @title : 'Title';
    customer : Association to one Customers;
    conversations : Composition of many Conversations on conversations.incidents = $self;
    status : Association to one Status;
    urgency : Association to one Urgency;
}

entity Customers : managed
{
    key ID : UUID;
    firstName : String(100);
    lastName : String(100);
    email : String(100);
    phone : String(100);
    incidents : Association to many Incidents on incidents.customer = $self;
}

entity Conversations : managed
{
    key ID : UUID;
    timestamp : DateTime
        @cds.on.insert : $now;
    author : String(100)
        @cds.on.insert : $user;
    message : String(100);
    incidents : Association to one Incidents;
}

entity Status : CodeList
{
    key code : StatusCode;
    criticality : Integer;
}

entity Urgency : CodeList
{
    key code : UrgencyCode;
}

type StatusCode : String enum
{
    new = 'N';
    assigned = 'A';
    in_process = 'I';
    on_hold = 'H';
    resolved = 'R';
    closed = 'C';
}

type UrgencyCode : String enum
{
    high = 'H';
    medium = 'M';
    low = 'L';
}
