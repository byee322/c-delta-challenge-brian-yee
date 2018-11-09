import React, { Component } from 'react'
import { connect, PromiseState } from 'react-refetch'
import styled from 'styled-components'

export const StyledHeader = styled.h1`
  font-size: 32px;
  text-transform: uppercase;
  font-weight: bold;
  text-align: center;
`
export const StyledButton = styled.button`
  font-size: 12px;
  text-transform: lowercase;
  margin: 0 2px;
`

export const ButtonContainer = styled.div`
  display: 12px;
  text-transform: uppercase;
  font-weight: bold;
  text-align: center;
`

class App extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      sortNamesAsc: null,
      sortScoreAsc: null,
      lastToggled: ''
    }
  }

  toggleSortNames = () => {
    this.setState({ sortNamesAsc: !this.state.sortNamesAsc, lastToggled: 'name'})
  }

  toggleSortScores = () => {
    this.setState({ sortScoreAsc: !this.state.sortScoreAsc, lastToggled: 'scores'})
  }

  render() {
    const { creativeQualitiesFetch } = this.props
    let names

    if(creativeQualitiesFetch.fulfilled){
      names = Object.keys(creativeQualitiesFetch.value)
      if(this.state.lastToggled === 'name'){
        if(this.state.sortNamesAsc){
          names = names.sort()
        }else{
          names = names.sort().reverse()
        }
      }

      if(this.state.lastToggled === 'scores'){
        if(this.state.sortScoreAsc){
          names = names.sort(function(a,b){ return creativeQualitiesFetch.value[a].score < creativeQualitiesFetch.value[b].score})
        }else{
          names = names.sort(function(a,b){ return creativeQualitiesFetch.value[a].score < creativeQualitiesFetch.value[b].score}).reverse()
        }
      }
    }
    
    return (
        <div>
          <StyledHeader>Creative Qualities</StyledHeader>

          <ButtonContainer>
            <StyledButton onClick={this.toggleSortNames} className="btn btn-secondary">Sort Name</StyledButton>
            <StyledButton onClick={this.toggleSortScores} className="btn btn-secondary">Sort Score</StyledButton>
          </ButtonContainer>

          <div className="qualities">
            <div className="col-md-12">
              <div className="row">
                {creativeQualitiesFetch.fulfilled ? 
                  names.map((name,score) => <Panel key={name+'-'+score} name={name} score={creativeQualitiesFetch.value[name].score} description={creativeQualitiesFetch.value[name].description} />) 
                  : "...Loading"}
              </div>
            </div>
          </div>
        </div>
    )
  }
}

export class Panel extends Component {
  constructor(props){
    super(props)
    this.state = {
      readMore: false
    }
  }

  toggleReadMore = () => {
    this.setState({
      readMore: !this.state.readMore
    })
  }
  render(){
    const { description, score, name } = this.props
    return(
    <div className="col-md-4">
      <div className={`panel panel-${name}`}>
        <div className="panel-heading">
          {name}
        </div>
        <div className="panel-body">
          <div className={`quality quality-${name}`}></div>
          <div className="score">
            <small>your score:</small>
            {score ? score : "-"}
          </div>
          <p>
            {this.state.readMore ? description : description.slice(0,120) + "..." }
          </p>
          {this.state.readMore ? <a onClick={this.toggleReadMore}>read less</a> : <a onClick={this.toggleReadMore}>read more</a> }            
        </div>
      </div>
    </div>
    )
  }
}



export default connect(props => ({
  creativeQualitiesFetch: `/creative_qualities.json`,
}))(App)