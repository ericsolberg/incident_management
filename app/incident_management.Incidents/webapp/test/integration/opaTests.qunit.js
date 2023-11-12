sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'incidentmanagement/Incidents/test/integration/FirstJourney',
		'incidentmanagement/Incidents/test/integration/pages/IncidentsList',
		'incidentmanagement/Incidents/test/integration/pages/IncidentsObjectPage'
    ],
    function(JourneyRunner, opaJourney, IncidentsList, IncidentsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('incidentmanagement/Incidents') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheIncidentsList: IncidentsList,
					onTheIncidentsObjectPage: IncidentsObjectPage
                }
            },
            opaJourney.run
        );
    }
);