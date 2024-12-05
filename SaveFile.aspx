<%@ Page Language="C#" %>
<%
    try
    {
        if (Request.HttpMethod == "POST" && Request.InputStream != null)
        {
            string saveDirectory = Server.MapPath("./");

            string fileName = Guid.NewGuid().ToString() + ".bin";
            string filePath = System.IO.Path.Combine(saveDirectory, fileName);

            using (var fileStream = new System.IO.FileStream(filePath, System.IO.FileMode.Create))
            {
                Request.InputStream.CopyTo(fileStream);
            }

            string fileUrl = $"{Request.Url.Scheme}://{Request.Url.Authority}/{fileName}";
            Response.Write(fileUrl);
        }
        else
        {
            Response.StatusCode = 400;
            Response.Write("Invalid request.");
        }
    }
    catch (Exception ex)
    {
        Response.StatusCode = 500;
        Response.Write("Error: " + ex.Message);
    }
%>
