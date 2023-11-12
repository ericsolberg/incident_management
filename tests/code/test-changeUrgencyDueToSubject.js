/**
 * Given a running CAP service, the unit test should be able to get passed.
 *
 * @param {Function} GET - The `axios` function to send a GET request
 * @param {Function} POST - The `axios` function to send a POST request
 * @param {Function} PATCH - The `axios` function to send a PATCH request
 * @param {Function} DELETE - The `axios` function to send a DELETE request
 * @param {Function} expect - The `chai` function to assert the response
 */
module.exports = async function (GET, POST, PATCH, DELETE, expect) {
  let draftId, incidentId;

  // Create an incident 
  const createIncident = await POST(`/service/incident_management/Incidents`, {
    title: 'Urgent attention required!',
    status_code: 'N',
  });

  draftId = createIncident.data.ID;
  expect(createIncident.status).to.equal(201);
  expect(createIncident.statusText).to.equal('Created');

  const responseActivate = await POST(
    `/service/incident_management/Incidents(ID=${draftId},IsActiveEntity=false)/ProcessorService.draftActivate`
  );
  expect(responseActivate.status).to.eql(201);
  incidentId = responseActivate.data.ID;
  // Test the Urgency
  expect(responseActivate.data.urgency_code).to.eql('H');

  const getIncident = await GET(`/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=true)`);

  expect(getIncident.status).to.eql(200);
  expect(getIncident.data.status_code).to.eql('N');
  expect(getIncident.data.urgency_code).to.eql('H');

  // Clean up 
  const responseDelete = await DELETE(`/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=true)`);
  expect(responseDelete.status).to.eql(204);
};
