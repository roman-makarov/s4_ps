function do_reset()
  {
    document.getElementById("documentfilter_by_date_start").value = "";
    document.getElementById("documentfilter_by_date_finish").value = "";
    document.getElementById("documentfilter_by_type").value = "";
    document.getElementById("documentfilter_document_name").value = "";
    document.getElementById("documentfilter_by_sender").value = "";
  }

document.getElementById("documentfilter_document_name").disabled=true;

document.getElementById('documentfilter_by_type').onchange = function() {
    if ( document.getElementById("documentfilter_by_type").value )
    {
      document.getElementById("documentfilter_document_name").disabled=false;
    }
    else
    {
      document.getElementById("documentfilter_document_name").disabled=true;
    }
}
