<%@ Page Language="C#" %>
<%
    try
    {
        if (Request.HttpMethod == "POST" && Request.InputStream != null)
        {
            // Lấy thư mục hiện tại chứa savefile.aspx
            string saveDirectory = Server.MapPath("./");

            // Tạo tên file ngẫu nhiên
            string fileName = Guid.NewGuid().ToString() + ".bin";
            string filePath = System.IO.Path.Combine(saveDirectory, fileName);

            // Lưu file
            using (var fileStream = new System.IO.FileStream(filePath, System.IO.FileMode.Create))
            {
                Request.InputStream.CopyTo(fileStream);
            }

            // Trả về URL của file
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
