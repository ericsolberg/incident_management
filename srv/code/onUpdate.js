/**
 * 
 * @Before(event = { "UPDATE" }, entity = "ProcessorService.Incidents")
 * @param {Object} request - User information, tenant-specific CDS model, headers and query parameters
*/
module.exports = async function (request) {
	const { status_code } = await SELECT.one(request.subject, i => i.status_code).where({ ID: request.data.ID })
	if (status_code === 'C')
		return request.reject(400, `Can't modify a closed incident`)
}