
window.onload = function () {
    const checkAll = document.getElementById('chkAll');
    const chks = document.querySelectorAll('input[name="chk"]');
    const chkBoxLength = chks.length;

    checkAll.addEventListener('click', function(event) {
        chks.forEach(function(value){
            value.checked = event.target.checked;
        });
    });

    chks.forEach(function(chk) {
        chk.addEventListener('click', function() {
            if (Array.from(chks).every(c => c.checked)) {
                checkAll.checked = true;
            } else {
                checkAll.checked = false;
            }
        });
    });
}

function sendData() {
    const data = {
        selectedLoanProduct: "${selectedLoanProduct}",
        selectedLoanData: "${selectedLoanData}",
        creditData: "${creditData}"
    };

    fetch('/loanSwitch/loanSwitchStep4', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(data)
    })
        .then(response => response.json())
        .then(data => {
            window.location.href = "/loanSwitch/loanSwitchStep4";
        });
}
$(document).ready(function() {
    $("#allAgree").change(function() {
        var isChecked = $(this).prop("checked"); // '전체 동의' 체크박스의 상태를 가져옴
        $(".form-check-input").prop("checked", isChecked); // 모든 체크박스의 상태를 '전체 동의' 체크박스와 동일하게 설정
    });

    // '전체 동의' 이외의 체크박스가 변경될 때
    $(".form-check-input:not(#allAgree)").change(function() {
        if ($(".form-check-input:not(#allAgree):checked").length === $(".form-check-input:not(#allAgree)").length) {
            // 모든 체크박스가 체크되면 '전체 동의' 체크박스도 체크
            $("#allAgree").prop("checked", true);
        } else {
            // 하나라도 체크가 안 되어 있으면 '전체 동의' 체크박스는 체크 해제
            $("#allAgree").prop("checked", false);
        }
    });
});
document.getElementById('step2').classList.add('active');