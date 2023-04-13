/// All possible status for a pagination.
enum PagingStatus {
  completed,
  noItemsFound,
  loadingFirstPage,
  ongoing,
  // 可以继续分页加载，但当前列表未占满视图（手动加载）
  // ongoingManual,
  firstPageError,
  subsequentPageError,
}
