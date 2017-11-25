# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TRIX
  console.log("sdsdsdsdsd")
  document.addEventListener 'trix-attachment-add', (event) ->
    attachment = event.attachment
    console.log("attachment123",attachment)

    if attachment.file
      console.log("file true")
      return sendFile(attachment)
    return

  document.addEventListener 'trix-attachment-remove', (event) ->
    attachment = event.attachment
    deleteFile attachment

  sendFile = (attachment) ->
    console.log("attachment-sendFile", attachment.attachment.fileObjectURL)
    file = attachment.attachment.file
    fileObjectURL = attachment.attachment.fileObjectURL
    form = new FormData()
    console.log("sendFile", file)
    console.log("FormData1", form)
    form.append 'Content-Type', "multipart/form-data"
    form.append 'picture[image]', fileObjectURL
    console.log("FormData2", form)
    xhr = new XMLHttpRequest
    xhr.open 'POST', '/pictures', true
    console.log("xhr", xhr)


    xhr.upload.onprogress = (event) ->
      progress = undefined
      progress = event.loaded / event.total * 100
      attachment.setUploadProgress progress

    xhr.onload = ->
      response = JSON.parse(@responseText)
      console.log("response", response)
      attachment.setAttributes
        url: response.url
        picture_id: response.picture_id
        href: response.url

    console.log("form",form)
    xhr.send form


  deleteFile = (n) ->
    $.ajax
      type: 'DELETE'
      url: '/pictures/' + n.attachment.attributes.values.picture_id
      cache: false
      contentType: false
      processData: false

  return