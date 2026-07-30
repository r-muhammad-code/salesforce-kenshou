public class AggregateResultIterator implements Iterator<AggregateResult>, Iterable<AggregateResult> {
    
    private List<AggregateResult> results{get;set;}
    private Integer index{get;set;}
    
    public AggregateResultIterator(String soql) {
        this.results = new List<AggregateResult>();
        this.results = Database.query(soql);
        this.index = 0;
    }

    public Boolean hasNext() {
        if (this.results.isEmpty()) {
            return false;
        }
        if (this.index >= this.results.size()) {
            return false;
        }
        return true;
    }

    public AggregateResult next() {
        return results[index++];
    }
    
    public Iterator<AggregateResult> Iterator() {
        return this;
    }
}