function pet(num) {
    var url = "/semi_PetDiary/pet_servlet";
    $.ajax({
        url: url + "?command=pet_Paging&count=" + num,
        type: "POST",
        dataType: "json",
        success: function (data) {
            $.each(data, function (key, value) {
                var dloc = "location.href='/semi_PetDiary/pet_servlet?command=pet_delete&pet_no=" + value.pet_no + "'";
                var uloc = "window.open('/semi_PetDiary/pet_servlet?command=pet_update_form&pet_no=" + value.pet_no + "', 'update', 'left=50, top=50, width=700, height=700')";
                $("#petImg").attr("src", value.pet_path);
                $("#petName").empty().append(value.pet_name);
                $("#petSpecies").empty().append(value.pet_species);
                $("#petBreed").empty().append(value.pet_breed);
                $("#petBirthday").empty().append(value.pet_birthday.substring(0, 10));
                $("#petGender").empty().append(value.pet_gender);
                $("#petVaccination").empty().append(value.pet_vaccination.substring(0, 10));
                $("#petDel").attr("onclick", dloc);
                $("#petUp").attr("onclick", uloc);
            });
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "<br>" + "message:" + request.responseText + "<br>" + "error:" + error);
        }
    })
}