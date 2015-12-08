// For complete examples and data files, please go to https://github.com/groupdocsassembly/GroupDocs_Assembly_NET
//Setting up source spreadsheet template
const String strPresentationTemplate = "Presentation Templates/In-Table Master-Detail_DT.pptx";
//Setting up destination document report 
const String strPresentationReport = "Presentation Reports/In-Table Master-Detail_DT Report.pptx";
try
{
    //Instantiate DocumentAssembler class
    DocumentAssembler assembler = new DocumentAssembler();
    //Call AssembleDocument to generate In-Table Master-Detail Report in presentation format
    assembler.AssembleDocument(CommonUtilities.GetSourceDocument(strPresentationTemplate), CommonUtilities.SetDestinationDocument(strPresentationReport), DataLayer.GetCustomersAndOrdersDataDT(), "ds");
}
catch (Exception ex)
{
    Console.WriteLine(ex.Message);
}
