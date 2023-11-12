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

  // Close incident
  const draftIncident = await POST(
    `/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
    { "PreserveChanges": true }
  );
  expect(draftIncident.status).to.equal(201);

  const updateDraftIncident = await PATCH(
    `/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=false)`,
    { status_code: 'C' }
  );
  expect(updateDraftIncident.status).to.equal(200);

  const responseActivateClosed = await POST(
    `/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`
  );
  expect(responseActivateClosed.status).to.eql(200);

  // Check status closed 
  const getClosedIncident = await GET(`/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=true)`);
  expect(getClosedIncident.status).to.eql(200);
  expect(getClosedIncident.data.status_code).to.eql('C');

  // Update a closed incident in draft
  const prepareReopenIncident = await POST(
    `/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=true)/ProcessorService.draftEdit`,
    { "PreserveChanges": true }
  );
  expect(prepareReopenIncident.status).to.equal(201);

  const updateReopenIncident = await PATCH(
    `/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=false)`,
    { status_code: 'N' }
  );
  expect(updateReopenIncident.status).to.equal(200);

  // Test the failure in saving the change of a closed incident
  try {
    const responseReopen = await POST(
      `/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=false)/ProcessorService.draftActivate`
    );
  } catch (error) {
    expect(error.response.status).to.eql(400);
    expect(error.response.data.error.message).to.include(`Can't modify a closed incident`);
  }

  // Delete incident
  const responseDelete = await DELETE(`/service/incident_management/Incidents(ID=${incidentId},IsActiveEntity=true)`);
  expect(responseDelete.status).to.eql(204);
};
