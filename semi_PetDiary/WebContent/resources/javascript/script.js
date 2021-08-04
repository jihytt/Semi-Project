$(function () {
    $(".smallPic").click(function () {
        var path =  $(this).attr("src");
        $("#bigPic").html("<img style='height: 400px' src=\"" + path + "\">");
        $(this).css("border", "2px solid black");
    });
});

$(function () {
    $("#uVaccin").on("input", function () {
        $("#uPet").attr("disabled", false);
    });
});

$(function () {
    $("#start_date").on("input", function () {
        $("#end_date").attr("disabled", false);
    });
});

$(function () {
    if ($("#name").value !== "" && $("#breed").value !== "" && $("#birthday") !== "" && $("#vaccination").value !== "") {
        $("#iPet").attr("disabled", false);
    }
});

$(function () {
    $(".iselectPic").on("click", function () {
        var src = this.getAttribute("src");
        location.href = "pet/pet_insert.jsp?src=" + src;
    });
});

$(function () {
    $(".uselectPic").on("click", function () {
        var src = this.getAttribute("src")
        location.href = "pet/pet_update.jsp?src=" + src;
    });
});

function petCheck() {
    if (frm.name.value === "") {
        alert("이름을 입력해주세요");
        return false;
    }

    if (frm.breed.value === "") {
        alert("품종을 입력해주세요");
        return false;
    }

    if (frm.birthday.value === "") {
        alert("생일을 입력해주세요");
        return false;
    }
    if (frm.vaccination.value === "") {
        alert("예방접종 예정일을 입력해주세요");
        return false;
    }
}