' For complete examples and data files, please go to https://github.com/groupdocsassembly/GroupDocs_Assembly_NET
'setting up source document template
Const strDocumentTemplate As [String] = "Word Templates/Bubble Chart_DB.docx"
'Setting up destination document report 
Const strDocumentReport As [String] = "Word Reports/Bubble Chart_DT Report.docx"
Try
    'Instantiate DocumentAssembler class
    Dim assembler As New DocumentAssembler()
    'initialize object of DocumentAssembler class 
    'Call AssembleDocument to generate Bubble Chart Report in document format
    assembler.AssembleDocument(CommonUtilities.GetSourceDocument(strDocumentTemplate), CommonUtilities.SetDestinationDocument(strDocumentReport), DataLayer.GetCustomersAndOrdersDataDT())
Catch ex As Exception
    Console.WriteLine(ex.Message)
