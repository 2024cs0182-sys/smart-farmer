export function Loading({ text = 'Loading...' }) {
  return <div className="state-card">{text}</div>;
}

export function ErrorState({ message, onRetry }) {
  return (
    <div className="state-card error-state">
      <strong>Unable to load data</strong>
      <span>{message}</span>
      {onRetry && <button className="retry-button" onClick={onRetry}>Retry</button>}
    </div>
  );
}

export function EmptyState({ text = 'No records found.' }) {
  return <div className="state-card">{text}</div>;
}
