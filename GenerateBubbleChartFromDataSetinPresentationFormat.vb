' For complete examples and data files, please go to https://github.com/groupdocsassembly/GroupDocs_Assembly_NET
'Setting up source spreadsheet template
Const strPresentationTemplate As [String] = "Presentation Templates/Bubble Chart_DB.pptx"
'Setting up destination document report 
Const strPresentationReport As [String] = "Presentation Reports/Bubble Chart_DT Report.pptx"
Try
    'Instantiate DocumentAssembler class
    Dim assembler As New DocumentAssembler()
    'Call AssembleDocument to generate Bubble Chart Report in presentation format
    assembler.AssembleDocument(CommonUtilities.GetSourceDocument(strPresentationTemplate), CommonUtilities.SetDestinationDocument(strPresentationReport), DataLayer.GetCustomersAndOrdersDataDT())
Catch ex As Exception
    Console.WriteLine(ex.Message)
