$(document).ready(function () {
    loadProducts('avgIntRate');

    $('#sorting').change(function () {
        var sortingMethod = $(this).val();
        loadProducts(sortingMethod);
    });
});

function getImagePath(fnstDvVal) {
    switch(fnstDvVal) {
        case '10927':
            return '/img/KB.png';
        case '10268':
            return '/img/HANA.png';
        case '2000293':
            return '/img/WOORI.png';
        case '11625':
            return '/img/SH.png';
        default:
            return '/img/default.png';
    }
}

function loadProducts(sortingMethod) {
    $.ajax({
        url: "/loanproducts",
        data: { sort: sortingMethod },
        success: function (data) {
            var listHtml = "";
            for (var i = 0; i < data.length; i++) {
                var imagePath = getImagePath(data[i].fnstDvVal);
                listHtml += '<li class="product-item">';
                listHtml += '<img class="product-image" src="' + imagePath + '" alt="' + data[i].fnstDvVal + '">';
                listHtml += '<div class="product-info">';
                listHtml += '<h3>' + data[i].loanPdctNm + '</h3>';
                listHtml += '<div class="limit-amount">' + parseInt(data[i].loanLimAmt).toLocaleString('en-US') + '원</div>';
                listHtml += '<div class="interest-rate">' + data[i].avgIntRate + '%</div>';
                listHtml += '<div class="early-repayment">' + data[i].earlyRepayFee + '%</div>';
                listHtml += '</div></li><hr>';
            }
            $('#product-list').html(listHtml);
        }
    });
}