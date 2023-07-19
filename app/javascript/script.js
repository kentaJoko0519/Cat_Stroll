// turbolinksの無効化
$(document).on('turbolinks:load', function() {
  $(function() {
    // 検索ボックスの中をクリアに
    $('.clearSearch').on('click', (e) => {
      $('.searchBox').val("")
    })
    // .tabがクリックされたときを指定
    $('.tab').click(function(){
      // 今ある.tab-activeを削除
      $('.tab-active').removeClass('tab-active');
      // クリックされた.tabに.tab-activeを追加
      $(this).addClass('tab-active');
      var idname = $(this).attr("id");
      let tabval = $(idname).val();
      $('input#select').val(idname);
      // 今ある.box-showを削除
      $('.box-show').removeClass('box-show');
      // indexに.tabのindex番号を代入
      const index = $(this).index();
      // .tabboxとindexの番号が同じ要素に.box-showを追加
      $('.tabbox').eq(index).addClass('box-show');
    });
  });
});

