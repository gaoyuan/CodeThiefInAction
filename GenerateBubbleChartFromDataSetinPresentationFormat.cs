// For complete examples and data files, please go to https://github.com/groupdocsassembly/GroupDocs_Assembly_NET
//Setting up source spreadsheet template
const String strPresentationTemplate = "Presentation Templates/Bubble Chart_DB.pptx";
//Setting up destination document report 
const String strPresentationReport = "Presentation Reports/Bubble Chart_DT Report.pptx";
try
{
    //Instantiate DocumentAssembler class
    DocumentAssembler assembler = new DocumentAssembler();
    //Call AssembleDocument to generate Bubble Chart Report in presentation format
    assembler.AssembleDocument(CommonUtilities.GetSourceDocument(strPresentationTemplate), CommonUtilities.SetDestinationDocument(strPresentationReport), DataLayer.GetCustomersAndOrdersDataDT());
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}
