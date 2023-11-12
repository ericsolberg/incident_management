using ProcessorService as service from '../../srv/service';

annotate service.Incidents with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : title,
        },
        {
            $Type : 'UI.DataField',
            Value : customer_ID,
            Label : '{i18n>Customer}',
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Status}',
            Value : status_code,
            Criticality : status.criticality,
        },
        {
            $Type : 'UI.DataField',
            Label : '{i18n>Urgency}',
            Value : urgency_code,
        },
    ]
);
annotate service.Incidents with {
    customer @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Customers',
        Parameters : [
            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : customer_ID,
                ValueListProperty : 'ID',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'firstName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'lastName',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'email',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'phone',
            },
            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'name',
            },
        ],
        Label : 'Customer',
    }
};
annotate service.Incidents with @(
    UI.FieldGroup #GeneratedGroup1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
            },
            {
                $Type : 'UI.DataField',
                Value : customer_ID,
                Label : '{i18n>Customer}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : '{i18n>Overview}',
            ID : 'i18nOverview',
            Facets : [
                {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup1',
        },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '{i18n>Details}',
                    ID : 'i18nDetails',
                    Target : '@UI.FieldGroup#i18nDetails',
                },],
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>Conversations}',
            ID : 'i18nConversations',
            Target : 'conversations/@UI.LineItem#i18nConversations',
        },
    ]
);
annotate service.Incidents with @(
    UI.SelectionFields : [
        status_code,
        urgency_code,
    ]
);
annotate service.Incidents with {
    status @Common.Label : '{i18n>Status}'
};
annotate service.Incidents with {
    urgency @Common.Label : '{i18n>Urgency}'
};
annotate service.Incidents with {
    status @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Status',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status_code,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Status',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Status with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextOnly,
    }
};
annotate service.Incidents with {
    urgency @(Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Urgency',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : urgency_code,
                    ValueListProperty : 'code',
                },
            ],
            Label : 'Urgency',
        },
        Common.ValueListWithFixedValues : true
)};
annotate service.Urgency with {
    code @Common.Text : {
        $value : descr,
        ![@UI.TextArrangement] : #TextOnly,
    }
};
annotate service.Incidents with {
    status @Common.Text : {
            $value : status.descr,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Incidents with {
    urgency @Common.Text : {
            $value : urgency.descr,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Incidents with {
    customer @Common.Text : {
            $value : customer.name,
            ![@UI.TextArrangement] : #TextOnly,
        }
};
annotate service.Incidents with @(
    UI.HeaderInfo : {
        Title : {
            $Type : 'UI.DataField',
            Value : title,
        },
        TypeName : '',
        TypeNamePlural : '',
        Description : {
            $Type : 'UI.DataField',
            Value : customer_ID,
        },
        TypeImageUrl : 'sap-icon://alert',
    }
);
annotate service.Incidents with @(
    UI.FieldGroup #i18nDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status_code,
            },{
                $Type : 'UI.DataField',
                Value : urgency_code,
            },],
    }
);
annotate service.Incidents with {
    customer @Common.ValueListWithFixedValues : false
};
annotate service.Customers with {
    ID @Common.Text : {
        $value : name,
        ![@UI.TextArrangement] : #TextOnly,
    }
};
annotate service.Conversations with @(
    UI.LineItem #i18nConversations : [
        {
            $Type : 'UI.DataField',
            Value : author,
            Label : 'author',
        },{
            $Type : 'UI.DataField',
            Value : timestamp,
            Label : 'timestamp',
        },{
            $Type : 'UI.DataField',
            Value : message,
            Label : 'message',
        },]
);
