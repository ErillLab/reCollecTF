export function expressionIdFromTfInstanceId(tfInstanceId) {
  const hex = tfInstanceId
    .toString(16)
    .toUpperCase()
    .padStart(7, "0");

  return `EXPREG_${hex}0`;
}

export function tfInstanceFromExpression(expressionId) {
  const tf_id = expressionId.replace("EXPREG_", "");
  const tf_id_parsed = parseInt(tf_id.slice(2, -1), 16);

  return tf_id_parsed
}
